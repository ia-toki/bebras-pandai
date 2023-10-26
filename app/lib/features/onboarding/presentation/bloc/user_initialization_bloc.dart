import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../authentication/register/repositories/register_user_repo.dart';

part 'user_initialization_event.dart';

part 'user_initialization_state.dart';

@injectable
@singleton
class UserInitializationBloc
    extends Bloc<UserInitializationEvent, UserInitializationState> {
  final RegisterUserRepository registerUserRepository;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserInitializationBloc(this.registerUserRepository) : super(UserInitializationInitial()) {
    on<OnboardingAuthEvent>(_auth);
  }

  FutureOr<void> _auth(OnboardingAuthEvent state,
      Emitter<UserInitializationState> emit,) async {
    // final creds = await _googleSignIn.signInSilently();
    final creds = FirebaseAuth.instance.currentUser;
    if (creds != null) {
      emit(UserAuthenticated());
      final userId = creds.uid;
      try {
        final data = await registerUserRepository.getById(userId);

        print(data);
        if (data == null) {
          emit(UserUnregistered());
        } else {
          emit(UserRegistered());
        }
      } catch (e) {
        emit(UserError(e.toString()));
      }
    } else {
      emit(UserUnauthenticated());
    }
  }
}
