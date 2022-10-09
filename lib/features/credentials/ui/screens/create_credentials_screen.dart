import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils.dart' as utils;
import '../../../../common/widgets/app_textfield.dart';
import '../../../../common/widgets/circular_loading.dart';
import '../../../../common/widgets/raised_button_icon.dart';
import '../../../main/main_cubit.dart';
import '../../bloc/credentials_cubit.dart';
import '../../model/credentials.dart';

class CreateCredentialsScreen extends StatefulWidget {
  const CreateCredentialsScreen();
  @override
  _CreateCredentialsScreenState createState() =>
      _CreateCredentialsScreenState();
}

class _CreateCredentialsScreenState extends State<CreateCredentialsScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameEmailController =
      TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordController.dispose();
    _usernameEmailController.dispose();
    _brandNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AppTextField(
                  controller: _usernameEmailController,
                  hint: 'Username/Email',
                  keyboard: TextInputType.emailAddress,
                  validator: utils.isNotEmpty,
                ),
                AppTextField(
                  controller: _brandNameController,
                  hint: 'Brand',
                  keyboard: TextInputType.name,
                  validator: utils.isNotEmpty,
                ),
                AppTextField(
                  controller: _passwordController,
                  hint: 'Password',
                  validator: utils.isNotEmpty,
                  isPassword: true,
                ),
                BlocConsumer<CredentialsCubit, CredentialsState>(
                  builder: (context, state) {
                    return state is AddCredentialInProgress
                        ? CircularLoading()
                        : RaisedButtonIcon(
                            onPressed: () {
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                context
                                    .read<CredentialsCubit>()
                                    .createCredentials(
                                      Credentials(
                                        _brandNameController.text,
                                        _usernameEmailController.text,
                                        _passwordController.text,
                                      ),
                                    );
                              }
                            },
                            icon: Icons.save,
                            label: 'Create',
                          );
                  },
                  listener: (context, state) {
                    // if added successfully navigated to crdentials page
                    if (state is CredentialsAdded) {
                      context.read<MainScreenCubit>().onChangeDrawerTab(3);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
