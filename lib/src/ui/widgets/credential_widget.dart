import 'package:flutter/material.dart';

class CredentialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ListTile(
      dense: true,
      leading: Hero(
        tag: 'logo',
        child: Text(
          'g',
          style: TextStyle(color: Colors.red),
        ),
      ),
      title: Text('jiincade@gmail.com'),
      horizontalTitleGap: 0.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(),
      ),
    );
  }
}
