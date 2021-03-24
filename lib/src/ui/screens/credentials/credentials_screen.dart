import 'package:credentials_management/src/ui/widgets/credentials_app_bar.dart';
import 'package:flutter/material.dart';

class CredentialsScreen extends StatefulWidget {
  const CredentialsScreen();

  @override
  _CredentialsState createState() => _CredentialsState();
}

class _CredentialsState extends State<CredentialsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: const CredentialsAppBar(
          title: 'Credentials',
        ),
      ),
      body: const SizedBox(),
    );
  }
}
