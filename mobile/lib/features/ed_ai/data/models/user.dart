import 'package:mobile/features/ed_ai/domains/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String role,
    required bool verify,
    required int points,
    required String id,
    required String username,
    DateTime? createAt,
    DateTime? updateAt,
    String? school,
    String? grade,
    DateTime? dateOfBirth,
    String? image,
    String? cover,
  }) : super(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          role: role,
          verify: verify,
          username: username,
          points: points,
          id: id,
          createAt: createAt,
          updateAt: updateAt,
          school: school,
          grade: grade,
          dateOfBirth: dateOfBirth,
          image: image,
          cover: cover,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['firstName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      verify: json['verify'],
      points: json['points'],
      id: json['id'],
      createAt:
          json['createAt'] != null ? DateTime.parse(json['createAt']) : null,
      updateAt:
          json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
      school: json['school'],
      grade: json['grade'],
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : null,
      image: json['image'],
      cover: json['cover'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'role': role,
      'verify': verify,
      'points': points,
      'id': id,
      'createAt': createAt?.toIso8601String(),
      'updateAt': updateAt?.toIso8601String(),
      'school': school,
      'grade': grade,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'image': image,
      'cover': cover,
    };
  }
}
