import 'package:flutter/material.dart';

class RaisedButtonIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  const RaisedButtonIcon({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(
        label,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
