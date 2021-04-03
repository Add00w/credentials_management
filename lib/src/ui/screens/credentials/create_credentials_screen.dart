import 'package:credentials_management/src/blocs/credentials/credentials_cubit.dart';
import 'package:credentials_management/src/common/utils.dart';
import 'package:credentials_management/src/models/credentials.dart';
import 'package:credentials_management/src/services/repositories/credentials_repository.dart';
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
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _brandNameController.dispose();
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
          create: (_) =>
              CredentialsCubit(context.read<CredentialsRepository>()),
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
                    controller: _usernameController,
                    hint: 'Username',
                    validator: Utils.isNotEmpty,
                  ),
                  AppTextField(
                    controller: _brandNameController,
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
                        context.read<CredentialsCubit>().createCredentials(
                              Credentials(
                                _brandNameController.text,
                                _usernameController.text,
                                _emailController.text,
                                _passwordController.text,
                                null,
                              ),
                            );
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
}
