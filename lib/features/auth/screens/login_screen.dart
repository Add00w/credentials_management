import 'package:credentials_management/common/widgets/raised_button_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/login_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<LoginCubit>().state;
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                shape: const StadiumBorder(),
                dismissDirection: DismissDirection.horizontal,
                backgroundColor: const Color.fromARGB(255, 48, 53, 112),
              ),
            );
          }
        },
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FlutterLogo(size: 64),
                  const SizedBox(
                    height: 46,
                  ),
                  Text(
                    'Welcome back',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 8.0),
                  RaisedButtonIcon(
                    onPressed: () {
                      context.read<LoginCubit>().loginWithGoogle();
                    },
                    icon: Icons.logo_dev,
                    label: 'Login with google',
                  ),
                ],
              ),
              if (state is LoginIsInProgress)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Loading...',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
