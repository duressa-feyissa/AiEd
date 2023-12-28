import 'package:mobile/features/ed_ai/domains/entities/submission.dart';

class SubmissionModel extends Submission {
  const SubmissionModel({
    required String problemId,
    required String userId,
    required int point,
    required bool isCorrect,
    required String submissionOn,
    required String answer,
    required DateTime attemptedAt,
    String? contestId,
    String? participationId,
    int? second,
  }) : super(
          problemId: problemId,
          userId: userId,
          point: point,
          isCorrect: isCorrect,
          submissionOn: submissionOn,
          answer: answer,
          attemptedAt: attemptedAt,
          contestId: contestId,
          participationId: participationId,
          second: second,
        );

  factory SubmissionModel.fromJson(Map<String, dynamic> json) {
    return SubmissionModel(
      problemId: json['problemId'],
      userId: json['userId'],
      point: json['point'],
      isCorrect: json['isCorrect'],
      submissionOn: json['submissionOn'],
      answer: json['answer'],
      attemptedAt: DateTime.parse(json['attemptedAt']),
      contestId: json['contestId'],
      participationId: json['participationId'],
      second: json['second'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'problemId': problemId,
      'userId': userId,
      'point': point,
      'isCorrect': isCorrect,
      'submissionOn': submissionOn,
      'answer': answer,
      'attemptedAt': attemptedAt.toIso8601String(),
      'contestId': contestId,
      'participationId': participationId,
      'second': second,
    };
  }
}
