import 'package:equatable/equatable.dart';

class Content extends Equatable {
  final String type;
  final String value;
  final String? id;

  const Content({
    required this.type,
    required this.value,
    this.id,
  });

  @override
  List<Object?> get props => [
        type,
        value,
        id,
      ];

  Content copyWith({
    String? type,
    String? value,
    String? id,
  }) {
    return Content(
      type: type ?? this.type,
      value: value ?? this.value,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
      'id': id,
    };
  }
}
