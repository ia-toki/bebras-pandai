import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

part 'user_initialization_event.dart';
part 'user_initialization_state.dart';

@injectable
@singleton
class UserInitializationBloc
    extends Bloc<UserInitializationEvent, UserInitializationState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  UserInitializationBloc() : super(UserInitializationInitial()) {
    on<OnboardingAuthEvent>(_auth);
  }

  FutureOr<void> _auth(
    OnboardingAuthEvent state,
    Emitter<UserInitializationState> emit,
  ) async {
    final creds = await _googleSignIn.signInSilently();

    if (creds != null) {
      emit(UserAuthenticated());
    } else {
      emit(UserUnauthenticated());
    }
  }
}
