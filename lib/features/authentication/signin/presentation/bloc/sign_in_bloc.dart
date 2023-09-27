import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../domain/use_case/sign_in_use_case.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

@injectable
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase _signInUseCase;
  SignInBloc(this._signInUseCase) : super(SignInInitialState()) {
    on<TriggerSignInEvent>(_userSignIn);
  }

  FutureOr<void> _userSignIn(
    TriggerSignInEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInLoadingState());

    final res = await _signInUseCase.execute();

    await res.fold(
      (left) {
        emit(
          SignInFailureState(
            message: left.message ?? 'Something went wrong',
          ),
        );
      },
      (right) async {
        emit(SignInSuccessState(user: right));
      },
    );
  }
}
