import 'package:mobile/features/ed_ai/domains/entities/auth.dart';

class AuthModel extends Auth {
  const AuthModel({required String token}) : super(token: token);

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {'token': token};
  }
}
