import 'package:flutter/material.dart';

class CredentialsAppBar extends StatelessWidget {
  const CredentialsAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      title: Text(title),
      automaticallyImplyLeading: false,
    );
  }
}
