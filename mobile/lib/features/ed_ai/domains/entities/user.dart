import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String username;
  final String phone;
  final String role;
  final bool verify;
  final int points;
  final String? image;
  final String? cover;
  final DateTime? createAt;
  final DateTime? updateAt;
  final String? school;
  final String? grade;
  final DateTime? dateOfBirth;

  const User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.verify,
    required this.username,
    required this.points,
    required this.id,
    this.createAt,
    this.updateAt,
    this.school,
    this.grade,
    this.dateOfBirth,
    this.image,
    this.cover,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        phone,
        role,
        verify,
        username,
        points,
        id,
        createAt,
        updateAt,
        school,
        grade,
        dateOfBirth,
        image,
        cover,
      ];

  User copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    bool? verify,
    String? username,
    int? points,
    String? id,
    DateTime? createAt,
    DateTime? updateAt,
    String? school,
    String? grade,
    DateTime? dateOfBirth,
    String? image,
    String? cover,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      verify: verify ?? this.verify,
      username: username ?? this.username,
      points: points ?? this.points,
      id: id ?? this.id,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      school: school ?? this.school,
      grade: grade ?? this.grade,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      image: image ?? this.image,
      cover: cover ?? this.cover,
    );
  }
}
