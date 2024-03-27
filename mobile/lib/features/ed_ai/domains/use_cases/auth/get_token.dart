import 'package:either_dart/either.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/use_cases/usecase.dart';
import 'package:mobile/features/ed_ai/domains/entities/auth.dart';
import 'package:mobile/features/ed_ai/domains/repositories/auth.dart';

class GetToken extends UseCase<Auth, NoParams> {
  final AuthRepository repository;

  GetToken(this.repository);

  @override
  Future<Either<Failure, Auth>> call(NoParams params) async {
    return await repository.getAuth();
  }
}


