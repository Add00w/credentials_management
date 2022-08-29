import 'dart:developer' show log;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

import './signup_screen.dart';
import '../../../common/utils.dart' as utils;
import '../../../common/widgets/app_textfield.dart';
import '../../../common/widgets/raised_button_icon.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/login_cubit.dart';
import '../bloc/signup_cubit.dart';
import '../repository/user_repository.dart';

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
                    validator: utils.isEmail,
                    keyboard: TextInputType.emailAddress,
                  ),
                  AppTextField(
                    controller: _passwordController,
                    hint: 'Password',
                    validator: utils.isNotEmpty,
                    keyboard: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  BlocConsumer<LoginCubit, LoginState>(
                    bloc: context.read<LoginCubit>(),
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
                      if (state is LoginFailed) {
                        //Show error dialog
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
                        onTap: _signUp,
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
      context.read<LoginCubit>().loginWithEmailAndPassword(
            _emailController.text,
            _passwordController.text,
          );
    }
  }

  Future<void> _fingerprint() async {
    final localAuth = LocalAuthentication();
    final bool didAuthenticate = await localAuth.authenticate(
      localizedReason: 'Please authenticate to show your account',
    );
    log(didAuthenticate.toString());
    if (didAuthenticate) {
      if (!mounted) return;
      context
          .read<LoginCubit>()
          .loginWithFingerprint(authenticated: didAuthenticate);
    }
  }

  void _signUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(
            authenticationBloc: context.read<AuthenticationBloc>(),
            userRepository: context.read<UserRepository>(),
          ),
          child: SignUpScreen(),
        ),
      ),
    );
  }

  void _forgotPassword() {}
}
