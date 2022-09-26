import 'dart:developer' show log;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import './common/widgets/circular_loading.dart';
import './features/auth/bloc/auth_bloc.dart';
import './features/auth/bloc/login_cubit.dart';
import './features/auth/repository/user_repository.dart';
import './features/auth/screens/login_screen.dart';
import './features/credentials/bloc/credentials_cubit.dart';
import './features/credentials/model/credentials.dart';
import './features/credentials/repository/credentials_repository.dart';
import './features/main/main_cubit.dart';
import './features/main/main_screen.dart';
import './features/main/widgets/drawer_icon.dart';
import './features/profile/cubit/profile_cubit.dart';
import './firebase_options.dart';

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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(CredentialsAdapter());
  final userRepo = UserRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthenticationBloc(userRepository: userRepo)..add(AppStarted()),
        ),
        BlocProvider(
          create: (context) => CredentialsCubit(CredentialsRepository()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => MainScreenCubit(),
        ),
        BlocProvider(
          create: (context) => DrawerIconCubit(),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: userRepo),
        ],
        child: CredentialsManagementApp(),
      ),
    ),
  );
  Bloc.observer = SimpleBlocDelegate();
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
                  ? BlocProvider(
                      create: (context) => ProfileCubit(
                        authenticationBloc: context.read<AuthenticationBloc>(),
                      )..profile(),
                      child: MainScreen(),
                    )
                  : BlocProvider<LoginCubit>(
                      create: (context) => LoginCubit(
                        userRepository: context.read<UserRepository>(),
                      ),
                      child: const LoginScreen(),
                    ),
        ),
      ),
    );
  }
}
