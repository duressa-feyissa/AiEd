import 'package:mobile/features/ed_ai/data/models/auth.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> login({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AuthModel> login({required String email, required String password}) {
    throw UnimplementedError();
  }
}
