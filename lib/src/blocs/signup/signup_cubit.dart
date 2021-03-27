import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:credentials_management/src/blocs/auth/auth_bloc.dart';
import 'package:credentials_management/src/services/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required this.authenticationBloc,
    required this.userRepository,
  }) : super(SignUpInitial());

  final AuthenticationBloc authenticationBloc;
  final UserRepository userRepository;
  Future<void> signUp(
      final String name, final String email, final String password) async {
    emit(SignUpInProgress());
    try {
      final token = await userRepository.signUp(
          name: name, email: email, password: password);
      authenticationBloc.add(LoggedIn(token));
      log(token);
      emit(SignUpSuccess());
    } catch (error) {
      log(error.toString());
    }
  }
}
