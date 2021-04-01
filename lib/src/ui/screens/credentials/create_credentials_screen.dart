import 'package:credentials_management/src/blocs/credentials/credentials_cubit.dart';
import 'package:credentials_management/src/common/utils.dart';
import 'package:credentials_management/src/ui/widgets/app_textfield.dart';
import 'package:credentials_management/src/ui/widgets/credentials_app_bar.dart';
import 'package:credentials_management/src/ui/widgets/raised_button_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateCredentialsScreen extends StatefulWidget {
  @override
  _CreateCredentialsScreenState createState() =>
      _CreateCredentialsScreenState();
}

class _CreateCredentialsScreenState extends State<CreateCredentialsScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _noteController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: const CredentialsAppBar(
          title: 'Create Credentials',
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: BlocProvider<CredentialsCubit>(
          create: (_) => CredentialsCubit(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  AppTextField(
                    controller: _emailController,
                    hint: 'Email',
                    validator: Utils.isEmail,
                  ),
                  AppTextField(
                    controller: _emailController,
                    hint: 'Username',
                    validator: Utils.isEmail,
                  ),
                  AppTextField(
                    controller: _noteController,
                    hint: 'Brand name',
                    validator: Utils.isNotEmpty,
                  ),
                  AppTextField(
                    controller: _passwordController,
                    hint: 'Password',
                    validator: Utils.isNotEmpty,
                  ),
                  RaisedButtonIcon(
                    onPressed: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        _submit();
                      }
                    },
                    icon: Icons.save,
                    label: 'Create',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submit() {}
}
