import 'package:either_dart/either.dart';
import 'package:mobile/core/errors/failure.dart';
import 'package:mobile/core/use_cases/usecase.dart';
import 'package:mobile/features/ed_ai/domains/repositories/auth.dart';

class DeleteAuth extends UseCase<void, NoParams> {
  final AuthRepository repository;

  DeleteAuth(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.deleteAuth();
  }
}
