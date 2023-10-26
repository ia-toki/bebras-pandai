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

class UserUnregistered extends SignInState {
  @override
  List<Object> get props => [];
}

class UserRegistered extends SignInState {
  @override
  List<Object> get props => [];
}

class UserError extends SignInState {
  final String error;

  const UserError(this.error);
  @override
  List<Object> get props => [error];
}
