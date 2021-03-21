import 'dart:developer';

import 'package:credentials_management/src/blocs/auth/auth_bloc.dart';
import 'package:credentials_management/src/blocs/login/login_bloc.dart';
import 'package:credentials_management/src/blocs/signup/signup_bloc.dart';
import 'package:credentials_management/src/common/utils.dart';
import 'package:credentials_management/src/services/repositories/user_repository.dart';
import 'package:credentials_management/src/ui/screens/signup_screen.dart';
import 'package:credentials_management/src/ui/widgets/app_textfield.dart';
import 'package:credentials_management/src/ui/widgets/raised_button_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 50),
            Text('Login', style: Theme.of(context).textTheme.headline4),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  AppTextField(
                    controller: _emailController,
                    hint: 'Email',
                    validator: Utils.isEmail,
                    keyboard: TextInputType.emailAddress,
                  ),
                  AppTextField(
                    controller: _passwordController,
                    hint: 'Password',
                    validator: Utils.isNotEmpty,
                    keyboard: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  BlocConsumer<LoginBloc, LoginState>(
                    bloc: context.read<LoginBloc>(),
                    builder: (context, state) {
                      return FractionallySizedBox(
                        widthFactor: 0.85,
                        child: ElevatedButton(
                          onPressed: _validateAndLogin,
                          child: state is LoginIsInProgress
                              ? const CircularProgressIndicator()
                              : const Text('Login'),
                        ),
                      );
                    },
                    listener: (context, state) {
                      if (state is LoginSucces) {
                        //login success
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: _forgotPassword,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: _signup,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'sign up',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  color: Colors.grey,
                  height: 1.5,
                  margin: const EdgeInsets.only(right: 5),
                ),
                Text('or', style: Theme.of(context).textTheme.caption),
                Container(
                  width: MediaQuery.of(context).size.width / 2.3,
                  color: Colors.grey,
                  height: 1.5,
                  margin: const EdgeInsets.only(left: 5),
                ),
              ],
            ),
            FractionallySizedBox(
              widthFactor: 0.85,
              child: RaisedButtonIcon(
                onPressed: _fingerprint,
                icon: Icons.fingerprint,
                label: 'Login with fingerprint',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(
            LoginWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  Future<void> _fingerprint() async {
    final localAuth = LocalAuthentication();
    final bool didAuthenticate = await localAuth.authenticate(
      localizedReason: 'Please authenticate to show account balance',
    );
    log(didAuthenticate.toString());
    if (didAuthenticate) {
      context.read<LoginBloc>().add(LoginWithFingerprint(authenticated: true));
    }
  }

  void _signup() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => BlocProvider<SignupBloc>(
                create: (_) => SignupBloc(
                  authenticationBloc: context.read<AuthenticationBloc>(),
                  userRepository: context.read<UserRepository>(),
                ),
                child: SignupScreen(),
              )),
    );
  }

  void _forgotPassword() {}
}
