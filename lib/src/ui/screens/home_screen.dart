import 'package:credentials_management/src/ui/widgets/credential_widget.dart';
import 'package:credentials_management/src/ui/widgets/credentials_app_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.1),
        child: const CredentialsAppBar(
          title: 'Home',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: Colors.white54)),
                gradient: LinearGradient(
                  colors: [Colors.white12, Colors.white10, Colors.black12],
                ),
              ),
              child: ListView(
                padding: const EdgeInsets.only(top: 90),
                children: const [
                  _ServicesWidget(
                    title: 'Wifi',
                    description: 'Your credentials are not uploaded to '
                        'network.',
                    icon: Icons.wifi_off_rounded,
                  ),
                  _ServicesWidget(
                    title: 'Encrypted',
                    description: 'All your credentials are encrypted, and no '
                        'one can read except you.',
                    icon: Icons.enhanced_encryption_rounded,
                  ),
                  _ServicesWidget(
                    title: 'Store',
                    description: 'Store all your passwords offline',
                    icon: Icons.save_rounded,
                  ),
                  _ServicesWidget(
                    title: 'No need to remember',
                    description: 'All you need is to access your account and '
                        'get the password you want.',
                    icon: Icons.memory,
                  ),
                  _ServicesWidget(
                    title: 'Easy access',
                    description: 'You can easily access your account by '
                        'fingerprint or password and username. ',
                    icon: Icons.accessibility_rounded,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 15.0,
              left: 20.5,
              child: Card(
                child: Container(
                  transform: Matrix4.skew(0.5, -0.3)
                    ..rotateX(-0.005)
                    ..rotateY(-0.5),
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 70,
                  color: Colors.brown,
                  child: const Text(
                      'You will get these advantages when using this '
                      'app.'),
                ),
              ),
            ),
            Positioned(
              bottom: -50.0,
              left: -40.5,
              right: -80,
              child: Container(
                transform: Matrix4.skew(0.5, -0.2)..rotateY(13.1),
                width: MediaQuery.of(context).size.width + 100,
                alignment: Alignment.center,
                height: 100,
                color: Colors.white30,
                child: const Text(
                  '😍',
                  style: TextStyle(fontSize: 50),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _ServicesWidget extends StatelessWidget {
  const _ServicesWidget(
      {Key? key,
      required this.title,
      required this.description,
      required this.icon})
      : super(key: key);
  final String title, description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(description),
      ),
    );
  }
}
