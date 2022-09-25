part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedOut extends AuthEvent {}
