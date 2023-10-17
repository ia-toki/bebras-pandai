import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../authentication/register/repositories/register_user_repo.dart';

part 'user_initialization_event.dart';

part 'user_initialization_state.dart';

@injectable
@singleton
class UserInitializationBloc
    extends Bloc<UserInitializationEvent, UserInitializationState> {
  final RegisterUserRepository registerUserRepository;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserInitializationBloc(this.registerUserRepository) : super(UserInitializationInitial()) {
    on<OnboardingAuthEvent>(_auth);
    on<GetUserData>(_checkUserRegistered);
  }

  FutureOr<void> _auth(OnboardingAuthEvent state,
      Emitter<UserInitializationState> emit,) async {
    final creds = await _googleSignIn.signInSilently();
    if (creds != null) {
      emit(UserAuthenticated());
    } else {
      emit(UserUnauthenticated());
    }
  }

  FutureOr<void> _checkUserRegistered(GetUserData state,
      Emitter<UserInitializationState> emit) async {
    emit(UserInitializationLoading());
    final creds = await _googleSignIn.signInSilently();
    if (creds != null) {
      final FirebaseAuth auth = FirebaseAuth.instance;
      String userId = auth.currentUser?.uid as String;
      try {
        final data = await registerUserRepository.getById(userId);

        if (data == null) {
          emit(UserUnregistered());
        } else {
          emit(UserRegistered());
        }
      } catch (e) {
        emit(UserError(e.toString()));
        // emit(Us)
      }
    }

    // emit(UserUnregistered());

  }

  FutureOr<void> _createUserData(CreateUserData state,
      Emitter<UserInitializationState> emit,) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String userId = auth.currentUser?.uid as String;
    emit(UserGetDataLoading());
    await Future.delayed(const Duration(seconds: 1));

    try {
      await registerUserRepository.create(
          userId: userId,
          email: state.email,
          name: state.name,
          birth_date: state.birth_date,
          school: state.school,
          province: state.province,
          bebras_biro: state.bebras_biro,
      );
      emit(UserDataUploaded());
    } catch (e) {
      // emit(Us)
    }
  }
}
