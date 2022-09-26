import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthenticationBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;

  AuthenticationBloc({
    required this.userRepository,
  }) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final currentUser = userRepository.currentUser;
      if (currentUser == null) {
        emit(Unauthenticated());
      } else {
        emit(Authenticated(currentUser));
      }
      await emit.forEach(
        FirebaseAuth.instance.idTokenChanges(),
        onData: (user) {
          return user == null ? Unauthenticated() : Authenticated(user as User);
        },
      );
    });

    on<LoggedOut>((event, emit) async {
      await userRepository
          .signOut()
          .whenComplete(() => emit(Unauthenticated()));
    });
  }
}
