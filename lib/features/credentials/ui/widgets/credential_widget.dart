import 'package:flutter/material.dart';

import '../../model/credentials.dart';

class CredentialWidget extends StatelessWidget {
  final Credentials credential;

  const CredentialWidget({Key? key, required this.credential})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: SizedBox(
        width: 20,
        height: 20,
        child: Hero(
          tag: 'logo',
          child: Image.network(
            credential.icon!,
            width: 20,
            height: 20,
          ),
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
