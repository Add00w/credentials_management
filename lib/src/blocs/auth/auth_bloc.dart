import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:credentials_management/src/services/repositories/secure_storage_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  AuthenticationBloc()
      : secureStorageRepo = SecureStorageRepository(),
        super(AuthInitial());
  final SecureStorageRepository secureStorageRepo;
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    // app start
    if (event is AppStarted) {
      final token = await secureStorageRepo.getToken();
      if (token.isNotEmpty) {
        yield Authenticated();
      } else {
        yield Unauthenticated();
      }
    }

    if (event is LoggedIn) {
      await secureStorageRepo.saveToken(event.token);
      yield Authenticated();
    }

    if (event is LoggedOut) {
      await secureStorageRepo.deleteToken();
      yield Unauthenticated();
    }
  }
}
