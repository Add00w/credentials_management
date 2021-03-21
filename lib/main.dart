import 'dart:developer';

import 'package:credentials_management/src/blocs/auth/auth_bloc.dart';
import 'package:credentials_management/src/blocs/login/login_bloc.dart';
import 'package:credentials_management/src/services/repositories/user_repository.dart';
import 'package:credentials_management/src/ui/screens/login_screen.dart';
import 'package:credentials_management/src/ui/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// class SimpleBlocDelegate extends BlocObserver {
//   @override
//   void onEvent(Bloc bloc, Object event) {
//     super.onEvent(bloc, event);
//     log(event.toString());
//   }

//   @override
//   void onTransition(Bloc bloc, Transition transition) {
//     super.onTransition(bloc, transition);
//     log(transition.toString());
//   }

//   @override
//   void onError(Cubit bloc, Object error, StackTrace stacktrace) {
//     super.onError(bloc, error, stacktrace);
//     log(error.toString());
//   }
// }

void main() {
  // Bloc.observer = SimpleBlocDelegate();

  runApp(BlocProvider(
    create: (context) => AuthenticationBloc()..add(AppStarted()),
    child: RepositoryProvider(
      create: (context) => UserRepository(),
      child: CredentialsManagementApp(),
    ),
  ));
}

class CredentialsManagementApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Credentials management app.',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color.fromRGBO(32, 33, 36, 1.0),
        primaryColor: Color.fromRGBO(48, 49, 52, 1.0),
        appBarTheme: AppBarTheme(centerTitle: true),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthState>(
          builder: (context, state) => state is Authenticated
              ? MainScreen()
              : BlocProvider<LoginBloc>(
                  create: (context) => LoginBloc(
                    authenticationBloc: context.read<AuthenticationBloc>(),
                    userRepository: context.read<UserRepository>(),
                  ),
                  child: LoginScreen(),
                )),
    );
  }
}
