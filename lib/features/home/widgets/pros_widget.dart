import 'package:flutter/material.dart';

class ProsWidget extends StatelessWidget {
  const ProsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}
