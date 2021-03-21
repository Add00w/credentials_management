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
      appBar: AppBar(
        title: Text('Credentials'),
      ),
      body: SizedBox(),
    );
  }
}
