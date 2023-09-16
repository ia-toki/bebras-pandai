part of 'user_initialization_bloc.dart';

abstract class UserInitializationEvent extends Equatable {
  const UserInitializationEvent();

  @override
  List<Object> get props => [];
}

class OnboardingAuthEvent extends UserInitializationEvent {}
