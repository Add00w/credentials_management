import 'dart:developer';

import 'package:credentials_management/src/blocs/auth/auth_bloc.dart';
import 'package:credentials_management/src/blocs/login/login_bloc.dart';
import 'package:credentials_management/src/services/repositories/user_repository.dart';
import 'package:credentials_management/src/ui/screens/login_screen.dart';
import 'package:credentials_management/src/ui/screens/main_screen.dart';
import 'package:credentials_management/src/ui/widgets/circular_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onCreate -- bloc: ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('onEvent -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange -- bloc: ${bloc.runtimeType}, change: $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('onTransition -- bloc: ${bloc.runtimeType}, transition: $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError -- bloc: ${bloc.runtimeType}, error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose -- bloc: ${bloc.runtimeType}');
  }
}

void main() {
  Bloc.observer = SimpleBlocDelegate();

  runApp(BlocProvider(
    create: (context) => AuthenticationBloc()..add(AppStarted()),
    child: RepositoryProvider(
      create: (context) => UserRepository(),
      child: CredentialsManagementApp(),
    ),
  ));
}

class CredentialsManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Credentials management app.',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromRGBO(32, 33, 36, 1.0),
        primaryColor: const Color.fromRGBO(48, 49, 52, 1.0),
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthState>(
        builder: (context, state) => state is AuthInitial
            ? CircularLoading()
            : state is Authenticated
                ? MainScreen()
                : BlocProvider<LoginBloc>(
                    create: (context) => LoginBloc(
                      authenticationBloc: context.read<AuthenticationBloc>(),
                      userRepository: context.read<UserRepository>(),
                    ),
                    child: LoginScreen(),
                  ),
      ),
    );
  }
}
