import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './main_cubit.dart';
import './widgets/bottom_nav_bar.dart';
import './widgets/credentials_drawer.dart';
import './widgets/drawer_icon.dart';
import '../../common/widgets/credentials_app_bar.dart';
import '../credentials/ui/screens/create_credentials_screen.dart';
import '../credentials/ui/screens/credentials_screen.dart';
import '../home/screens/home_screen.dart';
import '../profile/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  final _screens = const [
    HomeScreen(),
    CreateCredentialsScreen(),
    ProfileScreen(),
    CredentialsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final selectedPage = context.watch<MainScreenCubit>().state;
    final isCollapsed = context.watch<DrawerIconCubit>().state;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.1),
        child: const CredentialsAppBar(),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          const CredentialsDrawer(),
          AnimatedPositioned(
            left: isCollapsed ? 0 : 0.6 * screenWidth,
            right: isCollapsed ? 0 : -0.2 * screenWidth,
            top: isCollapsed ? 0 : screenHeight * 0.1,
            bottom: isCollapsed ? 0 : screenHeight * 0.1,
            duration: const Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    switchOutCurve: Curves.elasticOut,
                    child: _screens[selectedPage],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
