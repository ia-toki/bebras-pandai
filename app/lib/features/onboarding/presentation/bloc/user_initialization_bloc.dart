import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:yaml/yaml.dart';

import '../../../authentication/register/repositories/register_user_repo.dart';

part 'user_initialization_event.dart';
part 'user_initialization_state.dart';

@injectable
@singleton
class UserInitializationBloc
    extends Bloc<UserInitializationEvent, UserInitializationState> {
  
  final RegisterUserRepository registerUserRepository;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserInitializationBloc(this.registerUserRepository)
      : super(UserInitializationInitial()) {
    on<OnboardingAuthEvent>(_auth);
  }
  
  FutureOr<void> _auth(
    OnboardingAuthEvent state,
    Emitter<UserInitializationState> emit,
  ) async {
    // final creds = await _googleSignIn.signInSilently();
    final creds = FirebaseAuth.instance.currentUser;
    if (creds != null) {
      emit(UserAuthenticated());
      final userId = creds.uid;
      
      final yamlMap = loadYaml(await rootBundle.loadString('pubspec.yaml'));
      final versionWithBuildNumber = yamlMap['version'] as String;
      final parts = versionWithBuildNumber.split('+');
      final version = parts[0];

      final checkVersionApps = await registerUserRepository.getVersionApps(
        version
      );

      if (checkVersionApps == null) {
       return emit(UpdateAvailable());
      }

      try {
        final data = await registerUserRepository.getById(userId);

        print(data);
        if (data == null) {
          return emit(UserUnregistered());
        } else {
          return emit(UserRegistered());
        }
      } catch (e) {
        return emit(UserError(e.toString()));
      }
    } else {
      return emit(UserUnauthenticated());
    }
  }
}
