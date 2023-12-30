import 'package:equatable/equatable.dart';
import 'package:mobile/features/ed_ai/domains/entities/answer.dart';
import 'package:mobile/features/ed_ai/domains/entities/content.dart';

class Problem extends Equatable {
  final String id;
  final String source;
  final int correctPoint;
  final int wrongPoint;
  final List<Content> question;
  final Answer answer;
  final String target;
  final String courses;
  final String? difficulty;
  final String? topic;
  final String? grade;
  final String? unit;
  final String? essayId;
  final String? value;
  final int? year;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Problem({
    required this.id,
    required this.source,
    required this.correctPoint,
    required this.wrongPoint,
    required this.question,
    required this.answer,
    required this.target,
    required this.courses,
    this.difficulty,
    this.topic,
    this.grade,
    this.unit,
    this.essayId,
    this.value,
    this.year,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        source,
        correctPoint,
        wrongPoint,
        question,
        answer,
        target,
        courses,
        difficulty,
        topic,
        grade,
        unit,
        essayId,
        value,
        year,
        createdAt,
        updatedAt,
      ];

  Problem copyWith({
    String? id,
    String? source,
    int? correctPoint,
    int? wrongPoint,
    List<Content>? question,
    Answer? answer,
    String? target,
    String? courses,
    String? difficulty,
    String? topic,
    String? grade,
    String? unit,
    String? essayId,
    String? value,
    int? year,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Problem(
      id: id ?? this.id,
      source: source ?? this.source,
      correctPoint: correctPoint ?? this.correctPoint,
      wrongPoint: wrongPoint ?? this.wrongPoint,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      target: target ?? this.target,
      courses: courses ?? this.courses,
      difficulty: difficulty ?? this.difficulty,
      topic: topic ?? this.topic,
      grade: grade ?? this.grade,
      unit: unit ?? this.unit,
      essayId: essayId ?? this.essayId,
      value: value ?? this.value,
      year: year ?? this.year,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'source': source,
      'correctPoint': correctPoint,
      'wrongPoint': wrongPoint,
      'question': question.map((e) => e.toJson()).toList(),
      'answer': answer.toJson(),
      'target': target,
      'courses': courses,
      'difficulty': difficulty,
      'topic': topic,
      'grade': grade,
      'unit': unit,
      'essayId': essayId,
      'value': value,
      'year': year,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
