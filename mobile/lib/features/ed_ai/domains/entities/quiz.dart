import 'package:equatable/equatable.dart';
import 'package:mobile/features/ed_ai/domains/entities/problem.dart';
import 'package:mobile/features/ed_ai/domains/entities/submission.dart';

enum QuizStatus {
  notStarted,
  inProgress,
  completed,
}



class Quiz extends Equatable {
  final String id;
  final QuizStatus status;
  final double durationProgress;
  final int score;
  final List<Problem> problems;
  final List<Submission> submissions;
  final DateTime createdAt;
  final DateTime startsAt;
  final int duration;

  const Quiz({
    required this.id,
    required this.problems,
    required this.createdAt,
    required this.startsAt,
    required this.duration,
    this.submissions = const [],
    this.status = QuizStatus.notStarted,
    this.durationProgress = 0,
    this.score = 0,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        durationProgress,
        score,
        problems,
        submissions,
        createdAt,
        startsAt,
        duration,
      ];

  Quiz copyWith({
    String? id,
    QuizStatus? status,
    double? durationProgress,
    int? score,
    List<Problem>? problems,
    List<Submission>? submissions,
    DateTime? createdAt,
    DateTime? startsAt,
    int? duration,
  }) {
    return Quiz(
      id: id ?? this.id,
      status: status ?? this.status,
      durationProgress: durationProgress ?? this.durationProgress,
      score: score ?? this.score,
      problems: problems ?? this.problems,
      submissions: submissions ?? this.submissions,
      createdAt: createdAt ?? this.createdAt,
      startsAt: startsAt ?? this.startsAt,
      duration: duration ?? this.duration,
    );
  }
}
