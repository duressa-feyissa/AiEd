import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/features/ed_ai/domains/use_cases/problem/getById.dart'
    as get_by_id;
import 'package:mobile/features/ed_ai/domains/use_cases/problem/list.dart'
    as problem_list;
import 'package:stream_transform/stream_transform.dart';

import '../../../domains/entities/problem.dart';

part 'problem_event.dart';
part 'problem_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProblemBloc extends Bloc<ProblemEvent, ProblemState> {
  final problem_list.ListProblem listProblem;
  final get_by_id.ProblemGetById problemGetById;

  ProblemBloc({
    required this.listProblem,
    required this.problemGetById,
  }) : super(const ProblemState()) {
    on<GetProblems>(_getProblems,
        transformer: throttleDroppable(throttleDuration));
    on<GetProblem>(_getProblem,
        transformer: throttleDroppable(throttleDuration));
  }

  Future<void> _getProblems(
    GetProblems event,
    Emitter<ProblemState> emit,
  ) async {
    emit(state.copyWith(fetchProblemsStatus: FetchProblemsStatus.loading));

    final failureOrProblems = await listProblem(problem_list.Params(
      source: event.source,
      value: event.value,
      year: event.year,
      target: event.target,
      courses: event.courses,
      difficulty: event.difficulty,
      topic: event.topic,
      grade: event.grade,
    ));

    emit(failureOrProblems.fold(
      (failure) => state.copyWith(
        fetchProblemsStatus: FetchProblemsStatus.failure,
      ),
      (problems) => state.copyWith(
        fetchProblemsStatus: FetchProblemsStatus.success,
        problems: problems,
      ),
    ));
  }

  Future<void> _getProblem(
    GetProblem event,
    Emitter<ProblemState> emit,
  ) async {
    emit(state.copyWith(fetchProblemStatus: FetchProblemStatus.loading));

    final failureOrProblem = await problemGetById(get_by_id.Params(
      id: event.id,
    ));

    emit(failureOrProblem.fold(
      (failure) => state.copyWith(
        fetchProblemStatus: FetchProblemStatus.failure,
      ),
      (problem) => state.copyWith(
        fetchProblemStatus: FetchProblemStatus.success,
        problem: problem,
      ),
    ));
  }
}
