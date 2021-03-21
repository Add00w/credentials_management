import 'package:credentials_management/src/common/utils.dart';
import 'package:credentials_management/src/ui/widgets/app_textfield.dart';
import 'package:credentials_management/src/ui/widgets/raised_button_icon.dart';
import 'package:flutter/material.dart';

class CreateCredentialsScreen extends StatefulWidget {
  @override
  _CreateCredentialsScreenState createState() => _CreateCredentialsScreenState();
}

class _CreateCredentialsScreenState extends State<CreateCredentialsScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Credentials'),
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(primary: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              AppTextField(
                controller: _emailController,
                hint: 'UserName/Email',
                validator: Utils.isEmail,
              ),
              AppTextField(
                controller: _passwordController,
                hint: 'Password',
                validator: Utils.isNotEmpty,
              ),
              AppTextField(
                controller: _noteController,
                hint: 'Note',
                validator: Utils.isNotEmpty,
              ),
              RaisedButtonIcon(
                onPressed: _submit,
                icon: Icons.save,
                label: 'Create',
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {}
}
