import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/user_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required this.userRepository,
  }) : super(LoginInitial());

  final UserRepository userRepository;
  Future<void> loginWithGoogle() async {
    emit(LoginIsInProgress());
    try {
      await userRepository.signInWithGoogle();
    } on Exception catch (error) {
      emit(LoginFailed(message: error.toString()));
    }
  }
}
