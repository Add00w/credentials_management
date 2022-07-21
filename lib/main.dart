import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'src/blocs/auth/auth_bloc.dart';
import 'src/blocs/credentials/credentials_cubit.dart';
import 'src/blocs/login/login_cubit.dart';
import 'src/models/credentials.dart';
import 'src/services/repositories/credentials_repository.dart';
import 'src/services/repositories/user_repository.dart';
import 'src/ui/screens/login_screen.dart';
import 'src/ui/screens/main_screen.dart';
import 'src/ui/widgets/circular_loading.dart';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(CredentialsAdapter());
  runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthenticationBloc()..add(AppStarted()),
              ),
              BlocProvider(
                create: (context) => CredentialsCubit(CredentialsRepository()),
              ),
            ],
            child: MultiRepositoryProvider(
              providers: [
                RepositoryProvider(create: (context) => UserRepository()),
                // RepositoryProvider.value(value: _credentialsRepo),
              ],
              child: CredentialsManagementApp(),
            ),
          ),
        ),
        blocObserver: SimpleBlocDelegate(),
      );
    },
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
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
      home: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthState>(
          builder: (context, state) => state is AuthInitial
              ? CircularLoading()
              : state is Authenticated
                  ? MainScreen()
                  : BlocProvider<LoginCubit>(
                      create: (context) => LoginCubit(
                        authenticationBloc: context.read<AuthenticationBloc>(),
                        userRepository: context.read<UserRepository>(),
                      ),
                      child: LoginScreen(),
                    ),
        ),
      ),
    );
  }
}
