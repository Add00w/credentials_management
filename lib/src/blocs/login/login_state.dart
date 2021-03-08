part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginIsInProgress extends LoginState {}

class LoginSucces extends LoginState {}

class LoginFailed extends LoginState {
  final String message;

  LoginFailed({required this.message});
  @override
  List<Object> get props => [message];
}
