import 'package:credentials_management/src/ui/widgets/credentials_app_bar.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(
        child: Text(
          'data',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
