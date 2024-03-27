import 'package:mobile/features/ed_ai/data/models/user.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> createUser({
    required String firstName,
    required String lastName,
    required String username,
    required String phone,
    required String password,
    required String role,
    required String token,
  });

  Future<UserModel> updateUser({
    required String id,
    required String firstName,
    required String lastName,
    required String username,
    required String phone,
    required String role,
    required String token,
  });

  Future<UserModel> deleteUser({
    required String id,
    required String token,
  });

  Future<UserModel> me({
    required String token,
  });

  Future<UserModel> findByUsername({
    required String username,
    required String token,
  });

  Future<UserModel> findByPhone({
    required String phone,
    required String token,
  });

  Future<UserModel> findById({
    required String id,
    required String token,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserModel> createUser({
    required String firstName,
    required String lastName,
    required String username,
    required String phone,
    required String password,
    required String role,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> deleteUser({
    required String id,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> findByPhone({
    required String phone,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> findByUsername({
    required String username,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> findById({
    required String id,
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> me({
    required String token,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> updateUser({
    required String id,
    required String firstName,
    required String lastName,
    required String username,
    required String phone,
    required String role,
    required String token,
  }) {
    throw UnimplementedError();
  }
}
