import 'package:equatable/equatable.dart';

class Content extends Equatable {
  final String type;
  final String value;

  const Content({
    required this.type,
    required this.value,
  });

  @override
  List<Object?> get props => [
        type,
        value,
      ];

  Content copyWith({
    String? type,
    String? value,
  }) {
    return Content(
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
    };
  }
}
