import 'package:mobile/features/ed_ai/domains/entities/content.dart';

class ContentModel extends Content {
  const ContentModel({
    required String type,
    required String value,
    String? id,
  }) : super(
          type: type,
          value: value,
        );

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      type: json['type'],
      value: json['value'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
    };
  }
}
