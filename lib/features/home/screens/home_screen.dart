import 'package:flutter/material.dart';

import '../widgets/pros_widget.dart';
import '../widgets/service_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: const [
              ServicesWidget(
                title: 'Free',
                description: 'Free for you always.',
                icon: Icons.money_off_outlined,
              ),
              ServicesWidget(
                title: 'Synced',
                description: 'Your credentials are synced on all your devices.',
                icon: Icons.cloud_sync_outlined,
              ),
              ServicesWidget(
                title: 'Encrypted',
                description: 'All your credentials are encrypted, and no '
                    'one can read except you.',
                icon: Icons.enhanced_encryption_rounded,
              ),
              ServicesWidget(
                title: 'Offline/Online',
                description:
                    'All your credentials are available online and ofline.',
                icon: Icons.wifi_off_outlined,
              ),
              ServicesWidget(
                title: 'No need to remember',
                description: 'All you need is to access your account and '
                    'get the password you want.',
                icon: Icons.memory,
              ),
              ServicesWidget(
                title: 'Easy access',
                description:
                    'Just login to one account and get all your credentials.',
                icon: Icons.accessibility_rounded,
              ),
            ],
          ),
          const ProsWidget(),
        ],
      ),
    );
  }
}
