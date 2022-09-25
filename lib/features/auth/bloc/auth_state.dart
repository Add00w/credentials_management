part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
  final User user;

  Authenticated(this.user);
  @override
  List<Object> get props => [user];
}

class Unauthenticated extends AuthState {}
