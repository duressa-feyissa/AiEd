part of 'problem_bloc.dart';

sealed class ProblemState extends Equatable {
  const ProblemState();
  
  @override
  List<Object> get props => [];
}

final class ProblemInitial extends ProblemState {}
