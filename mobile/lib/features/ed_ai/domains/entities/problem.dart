import 'package:equatable/equatable.dart';
import 'package:mobile/features/ed_ai/domains/entities/answer.dart';
import 'package:mobile/features/ed_ai/domains/entities/content.dart';

class Problem extends Equatable {
  final String id;
  final String source;
  final String? value;
  final int? year;
  final String target;
  final String courses;
  final String difficulty;
  final String? topic;
  final String? grade;
  final int points;
  final List<Content> question;
  final Answer answer;

  const Problem({
    required this.id,
    required this.source,
    required this.target,
    required this.courses,
    required this.difficulty,
    required this.topic,
    required this.grade,
    required this.points,
    required this.question,
    required this.answer,
    required this.value,
    required this.year,
  });

  @override
  List<Object?> get props => [
        id,
        source,
        target,
        courses,
        difficulty,
        topic,
        grade,
        points,
        question,
        answer,
        value,
        year,
      ];

  Problem copyWith({
    String? id,
    String? source,
    String? target,
    String? courses,
    String? difficulty,
    String? topic,
    String? grade,
    int? points,
    List<Content>? question,
    Answer? answer,
    String? value,
    int? year,
  }) {
    return Problem(
      id: id ?? this.id,
      source: source ?? this.source,
      target: target ?? this.target,
      courses: courses ?? this.courses,
      difficulty: difficulty ?? this.difficulty,
      topic: topic ?? this.topic,
      grade: grade ?? this.grade,
      points: points ?? this.points,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      value: value ?? this.value,
      year: year ?? this.year,
    );
  }

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
