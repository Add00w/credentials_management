import 'package:credentials_management/src/blocs/auth/auth_bloc.dart';
import 'package:credentials_management/src/models/credentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedDestination = 0;

  late List<Credentials> _credentials;
  @override
  void initState() {
    super.initState();
    _credentials = [];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Addow',
                style: textTheme.headline6,
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.remove_red_eye_outlined),
              title: const Text('Credentials'),
              selected: _selectedDestination == 0,
              onTap: () => selectDestination(0),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              selected: _selectedDestination == 1,
              onTap: () => selectDestination(1),
            ),
            ListTile(
              leading: const Icon(Icons.info_outlined),
              title: const Text('About'),
              selected: _selectedDestination == 2,
              onTap: () => selectDestination(2),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              selected: _selectedDestination == 3,
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Passwords'),
      ),
      body: ListView.builder(
          itemCount: 5 /*_credentials.length*/,
          itemBuilder: (context, index) {
            return const ListTile(
              leading: Icon(Icons.g_translate),
              title: Text('Google'),
            );
          }),
    );
  }

  void _logout(BuildContext context) {
    context.read<AuthenticationBloc>().add(LoggedOut());
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
