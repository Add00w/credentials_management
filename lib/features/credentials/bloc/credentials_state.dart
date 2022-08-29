part of 'credentials_cubit.dart';

abstract class CredentialsState extends Equatable {
  const CredentialsState();
}

class CredentialsInitial extends CredentialsState {
  @override
  List<Object> get props => [];
}

class CredentialsLoaded extends CredentialsState {
  final List<Credentials> credentials;

  const CredentialsLoaded(this.credentials);
  @override
  List<Object?> get props => [credentials];
}

class CredentialsAdded extends CredentialsState {
  @override
  List<Object?> get props => [];
}

class AddCredentialInProgress extends CredentialsState {
  @override
  List<Object?> get props => [];
}

class CredentialsLoading extends CredentialsState {
  @override
  List<Object?> get props => [];
}
