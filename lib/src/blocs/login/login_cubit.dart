import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/repositories/user_repository.dart';
import '../auth/auth_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial());

  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  Future<void> loginWithEmailAndPassword(
    final String email,
    final String password,
  ) async {
    emit(LoginIsInProgress());
    try {
      final token = await userRepository.signIn(
        email: email,
        password: password,
      );
      authenticationBloc.add(LoggedIn(token));
    } catch (error) {
      emit(LoginFailed(message: error.toString()));
    }
  }

  void loginWithFingerprint({required final bool authenticated}) {
    authenticationBloc.add(LoggedIn('$authenticated'));
  }
}
