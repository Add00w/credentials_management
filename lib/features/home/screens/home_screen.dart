import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: const [
              _ServicesWidget(
                title: 'Free',
                description: 'Free for you always.',
                icon: Icons.money_off_outlined,
              ),
              _ServicesWidget(
                title: 'Synced',
                description: 'Your credentials are synced on all your devices.',
                icon: Icons.cloud_sync_outlined,
              ),
              _ServicesWidget(
                title: 'Encrypted',
                description: 'All your credentials are encrypted, and no '
                    'one can read except you.',
                icon: Icons.enhanced_encryption_rounded,
              ),
              _ServicesWidget(
                title: 'Offline/Online',
                description:
                    'All your credentials are available online and ofline.',
                icon: Icons.wifi_off_outlined,
              ),
              _ServicesWidget(
                title: 'No need to remember',
                description: 'All you need is to access your account and '
                    'get the password you want.',
                icon: Icons.memory,
              ),
              _ServicesWidget(
                title: 'Easy access',
                description:
                    'Just login to one account and get all your credentials.',
                icon: Icons.accessibility_rounded,
              ),
            ],
          ),
          Positioned(
            top: 25.0,
            right: 0.0,
            child: Container(
              transform: Matrix4.skew(0.5, -0.3)
                ..rotateX(-0.005)
                ..rotateY(-0.5),
              color: Colors.brown,
              padding: const EdgeInsets.all(4.0),
              width: 100,
              child: const Text(
                'Pros of using this app',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicesWidget extends StatelessWidget {
  const _ServicesWidget({
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
