import 'package:mobile/features/ed_ai/data/models/content.dart';
import 'package:mobile/features/ed_ai/domains/entities/answer.dart';
import 'package:mobile/features/ed_ai/domains/entities/content.dart';

class OptionModel extends Option {
  const OptionModel({
    required bool correct,
    required List<Content> data,
  }) : super(
          correct: correct,
          data: data,
        );

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      correct: json['correct'],
      data: (json['data'] as List)
          .map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AnswerModel extends Answer {
  const AnswerModel({
    required String type,
    List<Content>? explanation,
    List<Option>? option,
    String? short,
    bool? trueFalse,
  }) : super(
          type: type,
          option: option,
          short: short,
          trueFalse: trueFalse,
          explanation: explanation,
        );

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      type: json['type'],
      option: (json['option'] as List?)
          ?.map((e) => OptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      short: json['short'],
      trueFalse: json['trueFalse'],
      explanation: (json['explanation'] as List?)
          ?.map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
