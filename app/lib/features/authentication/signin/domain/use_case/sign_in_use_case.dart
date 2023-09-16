import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/bases/use_case/use_case.dart';
import '../../../../../core/errors/failure.dart';
import '../../../core/domain/repositories/authentication_repositories.dart';

@injectable
class SignInUseCase implements UseCase<void, void> {
  final AuthenticationRepository _repository;
  SignInUseCase(this._repository);
  @override
  Future<Either<Failure, User>> execute([void args]) {
    return _repository.signIn();
  }
}
