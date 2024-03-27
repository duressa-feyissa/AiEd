import 'package:equatable/equatable.dart';
import 'package:mobile/features/ed_ai/domains/entities/content.dart';


class Essay extends Equatable {
  final String id;
  final List<Content> question;

  const Essay({
    required this.id,
    required this.question,
  });

  @override
  List<Object?> get props => [
        id,
        question,
      ];

  Essay copyWith({
    String? id,
    List<Content>? question,
  }) {
    return Essay(
      id: id ?? this.id,
      question: question ?? this.question,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question.map((e) => e.toJson()).toList(),
    };
  }
}
