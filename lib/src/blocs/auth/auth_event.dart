part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable{
@override
  List<Object> get props => [];
}
class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {
  final String token;

  LoggedIn(this.token);

  @override
  List<Object> get props => [token];
}

class LoggedOut extends AuthEvent {}