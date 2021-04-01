import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'credentials_state.dart';

class CredentialsCubit extends Cubit<CredentialsState> {
  CredentialsCubit() : super(CredentialsInitial());
  Future<void>CreateCredentials()
}
