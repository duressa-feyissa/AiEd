import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'problem_event.dart';
part 'problem_state.dart';

class ProblemBloc extends Bloc<ProblemEvent, ProblemState> {
  ProblemBloc() : super(ProblemInitial()) {
    on<ProblemEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
