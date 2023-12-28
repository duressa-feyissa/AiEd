import 'dart:convert';

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
    required List<Content> question,
    required Answer answer,
    required correctPoint,
    required wrongPoint,
    String? essayId,
    String? difficulty,
    String? topic,
    String? unit,
    String? grade,
    String? value,
    int? year,
  }) : super(
          id: id,
          source: source,
          target: target,
          courses: courses,
          question: question,
          answer: answer,
          essayId: essayId,
          difficulty: difficulty,
          topic: topic,
          unit: unit,
          grade: grade,
          correctPoint: correctPoint,
          wrongPoint: wrongPoint,
          value: value,
          year: year,
        );

  factory ProblemModel.fromJson(Map<String, dynamic> json) {
    return ProblemModel(
      id: json['_id'] ?? '',
      source: json['source'] != null ? json['source']['name'] ?? '' : '',
      target: json['details'] != null ? json['details']['target'] ?? '' : '',
      courses: json['details'] != null ? json['details']['courses'] ?? '' : '',
      question: (json['question'] as List?)
              ?.map((e) => ContentModel.fromJson(e ?? {}))
              .toList() ??
          [],
      answer: AnswerModel.fromJson(json['answer'] ?? {}),
      essayId: json['essayId'] ?? '',
      difficulty:
          json['details'] != null ? json['details']['difficulty'] ?? '' : '',
      topic: json['details'] != null ? json['details']['topic'] ?? '' : '',
      unit: json['details'] != null ? json['details']['unit'] ?? '' : '',
      grade: json['details'] != null ? json['details']['grade'] ?? '' : '',
      correctPoint: json['point'] != null ? json['point']['correct'] ?? 0 : 0,
      wrongPoint: json['point'] != null ? json['point']['wrong'] ?? 0 : 0,
      value: json['source'] != null ? json['source']['value'] ?? '' : '',
      year: json['source'] != null ? json['source']['year'] ?? 0 : 0,
    );
  }

  Map<String, dynamic> toDbJson() {
    return {
      'id': id,
      'source': source,
      'target': target,
      'courses': courses,
      'question': jsonEncode(question),
      'answer': jsonEncode(answer),
      'essayId': essayId,
      'difficulty': difficulty,
      'topic': topic,
      'unit': unit,
      'grade': grade,
      'correctPoint': correctPoint,
      'wrongPoint': wrongPoint,
      'value': value,
      'year': year,
    };
  }

  ProblemModel.fromDbJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          source: json['source'],
          target: json['target'],
          courses: json['courses'],
          question: (jsonDecode(json['question']) as List)
              .map((e) => ContentModel.fromJson(e))
              .toList(),
          answer: AnswerModel.fromJson(jsonDecode(json['answer'])),
          essayId: json['essayId'],
          difficulty: json['difficulty'],
          topic: json['topic'],
          unit: json['unit'],
          grade: json['grade'],
          correctPoint: json['correctPoint'],
          wrongPoint: json['wrongPoint'],
          value: json['value'],
          year: json['year'],
        );
}
