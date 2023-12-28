import 'package:mobile/features/ed_ai/data/models/content.dart';
import 'package:mobile/features/ed_ai/domains/entities/answer.dart';
import 'package:mobile/features/ed_ai/domains/entities/content.dart';

class AnswerModel extends Answer {
  const AnswerModel({
    required String type,
    List<Content>? explanation,
    List<List<Content>>? option,
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
      option: json['option'] != null
          ? (json['option'] as List)
              .map((e) => (e as List)
                  .map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
                  .toList())
              .toList()
          : null,
      short: json['short'],
      trueFalse: json['trueFalse'],
      explanation: (json['explanation'] as List)
          .map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
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
