import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/services/secure_storage_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  final SecureStorageService secureStorageService;

  AuthenticationBloc()
      : secureStorageService = SecureStorageService(),
        super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final token = await secureStorageService.getToken();
      if (token.isNotEmpty) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });
    on<LoggedIn>((event, emit) async {
      await secureStorageService.saveToken(event.token);
      emit(Authenticated());
    });
    on<LoggedOut>((event, emit) async {
      await secureStorageService.deleteToken();
      emit(Unauthenticated());
    });
  }
}
