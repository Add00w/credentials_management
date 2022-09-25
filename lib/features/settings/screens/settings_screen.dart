import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            color: const Color(0xff2b2d42),
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Automatic Backup'),
                  onChanged: (bool value) {},
                  value: true,
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Backup Now'),
                      Icon(Icons.backup),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Card(
            color: const Color(0xff2b2d42),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Restore Now'),
                  Icon(Icons.restore),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
