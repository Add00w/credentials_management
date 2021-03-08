part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {}

class LoginWithEmailAndPassword extends LoginEvent {
  final String email, password;

  LoginWithEmailAndPassword({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class LoginWithFingerprint extends LoginEvent {
  final bool authenticated;

  LoginWithFingerprint({required this.authenticated});
  @override
  List<Object> get props => [authenticated];
}
