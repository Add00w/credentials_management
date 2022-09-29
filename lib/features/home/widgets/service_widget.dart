import 'package:flutter/material.dart';

class ServicesWidget extends StatelessWidget {
  const ServicesWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff2b2d42),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}
