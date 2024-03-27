import 'package:mobile/features/ed_ai/data/models/content.dart';
import 'package:mobile/features/ed_ai/domains/entities/content.dart';
import 'package:mobile/features/ed_ai/domains/entities/essay.dart';

class EssayModel extends Essay {
  const EssayModel({
    required String id,
    required List<Content> question,
  }) : super(
          id: id,
          question: question,
        );

  factory EssayModel.fromJson(Map<String, dynamic> json) {
    return EssayModel(
      id: json['id'],
      question: (json['question'] as List)
          .map((e) => ContentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question.map((e) => e.toJson()).toList(),
    };
  }
}
