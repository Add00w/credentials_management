import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/repositories/user_repository.dart';
import '../auth/auth_bloc.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required this.authenticationBloc,
    required this.userRepository,
  }) : super(SignUpInitial());

  final AuthenticationBloc authenticationBloc;
  final UserRepository userRepository;
  Future<void> signUp(
    final String name,
    final String email,
    final String password,
  ) async {
    emit(SignUpInProgress());
    try {
      final token = await userRepository.signUp(
        name: name,
        email: email,
        password: password,
      );
      authenticationBloc.add(LoggedIn(token));
      log(token);
      emit(SignUpSuccess());
    } catch (error) {
      log(error.toString());
    }
  }
}
