// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../features/authentication/core/data/datasource/_datasource.dart'
    as _i3;
import '../features/authentication/core/data/repositories/authentication_repository_impl.dart'
    as _i5;
import '../features/authentication/core/domain/repositories/authentication_repositories.dart'
    as _i4;
import '../features/authentication/signin/domain/use_case/sign_in_use_case.dart'
    as _i6;
import '../features/authentication/signin/presentation/bloc/sign_in_bloc.dart'
    as _i8;
import '../features/onboarding/presentation/bloc/user_initialization_bloc.dart'
    as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AuthenticationRemoteDataSource>(
        () => _i3.AudiometerRemoteDataSourceImpl());
    gh.factory<_i4.AuthenticationRepository>(() =>
        _i5.AudiometerRepositoryImpl(gh<_i3.AuthenticationRemoteDataSource>()));
    gh.factory<_i6.SignInUseCase>(
        () => _i6.SignInUseCase(gh<_i4.AuthenticationRepository>()));
    gh.factory<_i7.UserInitializationBloc>(() => _i7.UserInitializationBloc());
    gh.factory<_i8.SignInBloc>(() => _i8.SignInBloc(gh<_i6.SignInUseCase>()));
    return this;
  }
}
