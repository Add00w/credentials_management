import 'dart:async';
import 'dart:developer';
import 'package:credentials_management/src/blocs/auth/auth_bloc.dart';
import 'package:credentials_management/src/services/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({
    required this.authenticationBloc,
    required this.userRepository,
  })   : assert(authenticationBloc != null),
        assert(userRepository != null),
        super(SignupInitial());
  final AuthenticationBloc authenticationBloc;
  final UserRepository userRepository;
  @override
  Stream<SignupState> mapEventToState(
    SignupEvent event,
  ) async* {
    if (event is Signup) {
      yield SignupInProgress();
      try {
        final token = await userRepository.signUp(
            name: event.name, email: event.email, password: event.password);
        authenticationBloc.add(LoggedIn(token));
        log(token);
        yield SignupSuccess();
      } catch (error) {
        log(error.toString());
      }
    }
  }
}
