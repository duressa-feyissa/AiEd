import 'package:equatable/equatable.dart';
import 'package:mobile/features/ed_ai/domains/entities/content.dart';

class Answer extends Equatable {
  final String type;
  final List<List<Content>>? option;
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
    List<List<Content>>? option,
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
      'option': option?.map((e) => e.map((e) => e.toJson()).toList()).toList(),
      'short': short,
      'trueFalse': trueFalse,
      'explanation': explanation?.map((e) => e.toJson()).toList(),
    };
  }
}
