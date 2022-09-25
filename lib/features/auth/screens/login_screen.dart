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
      body: Center(
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
              const SimpleDialog(
                backgroundColor: Colors.transparent,
                shape: CircleBorder(),
                title: SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                titlePadding: EdgeInsets.all(24),
              ),
          ],
        ),
      ),
    );
  }
}
