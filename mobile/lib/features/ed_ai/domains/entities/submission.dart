import 'package:equatable/equatable.dart';

class Submission extends Equatable {
  final String problemId;
  final String userId;
  final int point;
  final bool isCorrect;
  final String submissionOn;
  final String answer;
  final DateTime attemptedAt;
  final String? contestId;
  final String? participationId;
  final int? second;

  const Submission({
    required this.problemId,
    required this.userId,
    required this.point,
    required this.isCorrect,
    required this.submissionOn,
    required this.answer,
    required this.attemptedAt,
    this.contestId,
    this.participationId,
    this.second,
  });

  @override
  List<Object?> get props => [
        problemId,
        userId,
        point,
        isCorrect,
        submissionOn,
        answer,
        attemptedAt,
        contestId,
        participationId,
        second,
      ];

  Submission copyWith({
    String? problemId,
    String? userId,
    int? point,
    bool? isCorrect,
    String? submissionOn,
    String? answer,
    DateTime? attemptedAt,
    String? contestId,
    String? participationId,
    int? second,
  }) {
    return Submission(
      problemId: problemId ?? this.problemId,
      userId: userId ?? this.userId,
      point: point ?? this.point,
      isCorrect: isCorrect ?? this.isCorrect,
      submissionOn: submissionOn ?? this.submissionOn,
      answer: answer ?? this.answer,
      attemptedAt: attemptedAt ?? this.attemptedAt,
      contestId: contestId ?? this.contestId,
      participationId: participationId ?? this.participationId,
      second: second ?? this.second,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'problemId': problemId,
      'userId': userId,
      'point': point,
      'isCorrect': isCorrect,
      'submissionOn': submissionOn,
      'answer': answer,
      'attemptedAt': attemptedAt,
      'contestId': contestId,
      'participationId': participationId,
      'second': second,
    };
  }
}
