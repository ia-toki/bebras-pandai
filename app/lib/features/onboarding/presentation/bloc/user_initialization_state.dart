part of 'user_initialization_bloc.dart';

abstract class UserInitializationState extends Equatable {
  const UserInitializationState();

  @override
  List<Object> get props => [];
}

class UserInitializationInitial extends UserInitializationState {}

class UserInitializationLoading extends UserInitializationState {}

class UserAuthenticated extends UserInitializationState {}

class UserUnauthenticated extends UserInitializationState {}
