import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.add), onPressed: () {}),
        actions: [
          PopupMenuButton(itemBuilder: (_) {
            return PopupMenuItem(child: Text('test')) as List<PopupMenuEntry>;
          })
        ],
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
