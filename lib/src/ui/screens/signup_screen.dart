import 'package:credentials_management/src/blocs/signup/signup_cubit.dart';
import 'package:credentials_management/src/common/utils.dart';
import 'package:credentials_management/src/ui/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 50),
            Text('Sign Up', style: Theme.of(context).textTheme.headline4),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: <Widget>[
                  AppTextField(
                    controller: _nameController,
                    hint: 'Name',
                    validator: Utils.isNotEmpty,
                  ),
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
                  BlocConsumer<SignUpCubit, SignUpState>(
                    bloc: context.read<SignUpCubit>(),
                    builder: (context, state) {
                      return FractionallySizedBox(
                        widthFactor: 0.85,
                        child: ElevatedButton(
                          onPressed: _validateAndSignUp,
                          child: state is SignUpInProgress
                              ? const CircularProgressIndicator()
                              : const Text('Sign Up'),
                        ),
                      );
                    },
                    listener: (context, state) {
                      if (state is SignUpSuccess) {
                        Navigator.of(context).maybePop();
                      } else if (state is SignUpFailed) {
                        // Show ErrorDialog
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('have an account?'),
                      InkWell(
                        onTap: _login,
                        child: const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validateAndSignUp() {
    if (_formKey.currentState!.validate()) {
      context.read<SignUpCubit>().signUp(
            _nameController.text,
            _emailController.text,
            _passwordController.text,
          );
    }
  }

  void _login() {
    Navigator.maybePop(context);
  }
}
