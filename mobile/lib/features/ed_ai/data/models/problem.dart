import 'package:mobile/features/ed_ai/data/models/answer.dart';
import 'package:mobile/features/ed_ai/data/models/content.dart';
import 'package:mobile/features/ed_ai/domains/entities/answer.dart';
import 'package:mobile/features/ed_ai/domains/entities/content.dart';
import 'package:mobile/features/ed_ai/domains/entities/problem.dart';

class ProblemModel extends Problem {
  const ProblemModel({
    required String id,
    required String source,
    required String target,
    required String courses,
    required String difficulty,
    String? topic,
    String? grade,
    String? value,
    int? year,
    required int points,
    required List<Content> question,
    required Answer answer,
  }) : super(
          id: id,
          source: source,
          target: target,
          courses: courses,
          difficulty: difficulty,
          topic: topic,
          grade: grade,
          points: points,
          question: question,
          answer: answer,
          value: value,
          year: year,
        );

  factory ProblemModel.fromJson(Map<String, dynamic> json) {
    return ProblemModel(
      id: json['id'],
      source: json['source']['name'],
      target: json['details']['target'],
      courses: json['details']['courses'],
      difficulty: json['details']['difficulty'],
      topic: json['details']['topic'],
      grade: json['details']['grade'],
      points: json['points'],
      question: (json['question'] as List)
          .map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      answer: AnswerModel.fromJson(json['answer'] as Map<String, dynamic>),
      value: json['source']['value'],
      year: json['source']['year'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source': source,
      'target': target,
      'courses': courses,
      'difficulty': difficulty,
      'topic': topic,
      'grade': grade,
      'points': points,
      'question': question.map((e) => e.toJson()).toList(),
      'answer': answer.toJson(),
      'value': value,
      'year': year,
    };
  }
}
