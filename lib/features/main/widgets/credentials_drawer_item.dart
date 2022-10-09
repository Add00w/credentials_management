import 'package:flutter/material.dart';

class CredentialsDrawerItem extends StatelessWidget {
  const CredentialsDrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    required this.selected,
  });
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      selected: selected,
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0.0,
      leading: Icon(icon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      onTap: onTap,
    );
  }
}
