import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile/core/use_cases/usecase.dart' as usecase;
import 'package:mobile/features/ed_ai/domains/use_cases/problem/delete.dart'
    as problem_delete;
import 'package:mobile/features/ed_ai/domains/use_cases/problem/getById.dart'
    as get_by_id;
import 'package:mobile/features/ed_ai/domains/use_cases/problem/last.dart'
    as last_update_problem;
import 'package:mobile/features/ed_ai/domains/use_cases/problem/list.dart'
    as problem_list;
import 'package:mobile/features/ed_ai/domains/use_cases/problem/sync.dart'
    as sync;
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
  final problem_delete.DeleteProblem problemDelete;
  final last_update_problem.LastUpdatedProblem lastUpdatedProblem;
  final sync.SyncProblem syncProblem;

  ProblemBloc({
    required this.listProblem,
    required this.problemDelete,
    required this.problemGetById,
    required this.lastUpdatedProblem,
    required this.syncProblem,
  }) : super(const ProblemState()) {
    on<GetProblems>(_getProblems,
        transformer: throttleDroppable(throttleDuration));
    on<GetProblem>(_getProblem,
        transformer: throttleDroppable(throttleDuration));
    on<DeleteProblem>(_deleteProblem,
        transformer: throttleDroppable(throttleDuration));
    on<GetLastUpdate>(_lastUpdatedProblem,
        transformer: throttleDroppable(throttleDuration));
    on<SyncProblem>(_syncProblem,
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
      (problems) {
        return state.copyWith(
          fetchProblemsStatus: FetchProblemsStatus.success,
          problems: problems,
        );
      },
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

  Future<void> _deleteProblem(
    DeleteProblem event,
    Emitter<ProblemState> emit,
  ) async {
    emit(state.copyWith(deleteProblemStatus: DeleteProblemStatus.loading));

    final failureOrProblem = await problemDelete(problem_delete.Params(
      id: event.id,
    ));

    emit(failureOrProblem.fold(
      (failure) => state.copyWith(
        deleteProblemStatus: DeleteProblemStatus.failure,
      ),
      (problemId) => state.copyWith(
        deleteProblemStatus: DeleteProblemStatus.success,
        problems:
            state.problems.where((element) => element.id != problemId).toList(),
      ),
    ));
  }

  Future<void> _lastUpdatedProblem(
    GetLastUpdate event,
    Emitter<ProblemState> emit,
  ) async {
    emit(state.copyWith(
        lastUpdatedProblemStatus: LastUpdatedProblemStatus.loading));

    final failureOrProblem = await lastUpdatedProblem(usecase.NoParams());

    emit(failureOrProblem.fold(
      (failure) => state.copyWith(
        lastUpdatedProblemStatus: LastUpdatedProblemStatus.failure,
      ),
      (problem) => state.copyWith(
        lastUpdatedProblemStatus: LastUpdatedProblemStatus.success,
        lastUpdatedProblem: problem,
      ),
    ));
  }

  Future<void> _syncProblem(
    SyncProblem event,
    Emitter<ProblemState> emit,
  ) async {
    emit(state.copyWith(syncProblemStatus: SyncProblemStatus.loading));

    final failureOrProblem = await syncProblem(sync.Params(
      lastUpdated: event.lastUpdated,
      skip: event.skip,
      limit: event.limit,
    ));

    emit(failureOrProblem.fold(
        (failure) => state.copyWith(
              syncProblemStatus: SyncProblemStatus.failure,
              syncfetch: false,
            ), (problems) {
      return state.copyWith(
          syncProblemStatus: SyncProblemStatus.success,
          syncfetch: problems.isNotEmpty ? true : false,
          problemsToSync: [
            ...state.problemsToSync,
            ...problems,
          ]);
    }));
  }
}
