import 'package:credentials_management/src/blocs/signup/signup_bloc.dart';
import 'package:credentials_management/src/common/utils.dart';
import 'package:credentials_management/src/ui/widgets/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(height: 50),
            Text('Signup', style: Theme.of(context).textTheme.headline4),
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
                  BlocConsumer<SignupBloc, SignupState>(
                    bloc: context.read<SignupBloc>(),
                    builder: (context, state) {
                      return FractionallySizedBox(
                        widthFactor: 0.85,
                        child: ElevatedButton(
                          onPressed: _validateAndSignup,
                          child: state is SignupInProgress
                              ? const CircularProgressIndicator()
                              : const Text('Signup'),
                        ),
                      );
                    },
                    listener: (context, state) {
                      if (state is SignupSuccess) {
                        Navigator.of(context).maybePop();
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

  void _validateAndSignup() {
    if (_formKey.currentState!.validate()) {
      context.read<SignupBloc>().add(
            Signup(
              name: _nameController.text,
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
  }

  void _login() {
    Navigator.maybePop(context);
  }
}
