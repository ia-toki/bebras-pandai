part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInSuccessState extends SignInState {
  final User user;

  const SignInSuccessState({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class SignInFailureState extends SignInState {
  final String message;

  const SignInFailureState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
