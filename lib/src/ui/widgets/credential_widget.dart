import 'package:credentials_management/src/models/credentials.dart';
import 'package:flutter/material.dart';

class CredentialWidget extends StatelessWidget {
  final Credentials credential;

  const CredentialWidget({Key? key, required this.credential})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Hero(
        tag: 'logo',
        child: Text(
          credential.brandName.characters.first,
          style: const TextStyle(color: Colors.red),
        ),
      ),
      title: Text(credential.email),
      horizontalTitleGap: 0.0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(),
      ),
    );
  }
}
