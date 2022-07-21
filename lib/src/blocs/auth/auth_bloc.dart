import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/repositories/secure_storage_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  final SecureStorageRepository secureStorageRepo;

  AuthenticationBloc()
      : secureStorageRepo = SecureStorageRepository(),
        super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final token = await secureStorageRepo.getToken();
      if (token.isNotEmpty) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });
    on<LoggedIn>((event, emit) async {
      await secureStorageRepo.saveToken(event.token);
      emit(Authenticated());
    });
    on<LoggedOut>((event, emit) async {
      await secureStorageRepo.deleteToken();
      emit(Unauthenticated());
    });
  }
}
