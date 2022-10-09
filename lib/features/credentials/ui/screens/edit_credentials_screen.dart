import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/utils.dart' as utils;
import '../../../../common/widgets/app_textfield.dart';
import '../../../../common/widgets/circular_loading.dart';
import '../../../../common/widgets/raised_button_icon.dart';
import '../../bloc/credentials_cubit.dart';
import '../../model/credentials.dart';

class EditCredentialsScreen extends StatefulWidget {
  const EditCredentialsScreen({
    required this.index,
    required this.credentials,
  });
  final int index;
  final Credentials credentials;

  @override
  _EditCredentialsScreenState createState() => _EditCredentialsScreenState();
}

class _EditCredentialsScreenState extends State<EditCredentialsScreen> {
  static late Credentials credential;
  @override
  void initState() {
    super.initState();
    credential = widget.credentials;
    _passwordController = TextEditingController(text: credential.password);
    _usernameEmailController =
        TextEditingController(text: credential.userNameOrEmail);
    _brandNameController = TextEditingController(text: credential.brand);
  }

  late TextEditingController _passwordController;
  late TextEditingController _usernameEmailController;
  late TextEditingController _brandNameController =
      TextEditingController(text: credential.brand);

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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xff2b2d42),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    return state is CredentialsEditInProgress
                        ? CircularLoading()
                        : RaisedButtonIcon(
                            onPressed: () {
                              _formKey.currentState!.save();
                              if (_formKey.currentState!.validate()) {
                                context.read<CredentialsCubit>().edit(
                                      credential.id!,
                                      widget.index,
                                      Credentials(
                                        _brandNameController.text,
                                        _usernameEmailController.text,
                                        _passwordController.text,
                                        icon: credential.icon,
                                        id: credential.id,
                                        synced: credential.synced,
                                      ),
                                    );
                              }
                            },
                            icon: Icons.edit,
                            label: 'Edit',
                          );
                  },
                  listener: (context, state) {
                    // if added successfully navigated to crdentials page
                    if (state is CredentialsEdited) {
                      Navigator.of(context).pop();
                      context.read<CredentialsCubit>().getCredentials();
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
