import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/errors/failure.dart';
import '../../../../../core/client/api_call.dart';
import '../../domain/repositories/authentication_repositories.dart';
import '../datasource/_datasource.dart';

@Injectable(as: AuthenticationRepository)
class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;

  AuthenticationRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, User>> signIn() {
    return apiCall(_remoteDataSource.signIn());
  }
}
