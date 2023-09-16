import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../core/errors/failure.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> signIn();
}
