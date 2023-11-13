part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeSuccess extends HomeState {
  final RegisteredUserModel user;

  HomeSuccess(
    this.user,
  );

  @override
  List<Object> get props => [user];
}

class HomeFailed extends HomeState {
  final String error;

  HomeFailed(this.error);
  @override
  List<Object> get props => [error];
}
