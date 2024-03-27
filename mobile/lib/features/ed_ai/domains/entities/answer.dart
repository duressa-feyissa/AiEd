import 'package:equatable/equatable.dart';
import 'package:mobile/features/ed_ai/domains/entities/content.dart';

class Option extends Equatable {
  final bool correct;
  final List<Content> data;

  const Option({
    required this.correct,
    required this.data,
  });

  @override
  List<Object?> get props => [
        correct,
        data,
      ];

  Option copyWith({
    bool? correct,
    List<Content>? data,
  }) {
    return Option(
      correct: correct ?? this.correct,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correct': correct,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class Answer extends Equatable {
  final String type;
  final List<Option>? option;
  final String? short;
  final bool? trueFalse;
  final List<Content>? explanation;

  const Answer({
    required this.type,
    this.option,
    this.short,
    this.trueFalse,
    required this.explanation,
  });

  @override
  List<Object?> get props => [
        type,
        option,
        short,
        trueFalse,
        explanation,
      ];

  Answer copyWith({
    String? type,
    List<Option>? option,
    String? short,
    bool? trueFalse,
    List<Content>? explanation,
  }) {
    return Answer(
      type: type ?? this.type,
      option: option ?? this.option,
      short: short ?? this.short,
      trueFalse: trueFalse ?? this.trueFalse,
      explanation: explanation ?? this.explanation,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'option': option?.map((e) => e.toJson()).toList(),
      'short': short,
      'trueFalse': trueFalse,
      'explanation': explanation?.map((e) => e.toJson()).toList(),
    };
  }
}
