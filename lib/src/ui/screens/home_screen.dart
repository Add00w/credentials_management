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
        padding: const EdgeInsets.only(top: 50),
        child: Stack(
          alignment: Alignment.center,
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
              margin: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('data'),
                  Text('data'),
                  Text('data'),
                  Text('data'),
                ],
              ),
            ),
            Positioned(
              top: 0.0,
              left: 5.5,
              child: Container(
                transform: Matrix4.skewX(0.5)
                  ..rotateX(0.1)
                  ..rotateY(-0.5),
                width: MediaQuery.of(context).size.width * 0.3,
                height: 100,
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }
}
