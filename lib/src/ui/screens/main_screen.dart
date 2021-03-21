import 'package:credentials_management/src/blocs/shared/main_screen_cubit.dart';
import 'package:credentials_management/src/ui/screens/about_screen.dart';
import 'package:credentials_management/src/ui/screens/contact_screen.dart';
import 'package:credentials_management/src/ui/screens/credentials/create_credentials_screen.dart';
import 'package:credentials_management/src/ui/screens/credentials/credentials_screen.dart';
import 'package:credentials_management/src/ui/screens/home_screen.dart';
import 'package:credentials_management/src/ui/screens/profile_screen.dart';
import 'package:credentials_management/src/ui/screens/settings_screen.dart';
import 'package:credentials_management/src/ui/widgets/credentials_drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  late double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 500);
  late AnimationController _controller;

  AppBar appBar = AppBar();
  double borderRadius = 0.0;

  int _navBarIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {
        _navBarIndex = tabController.index;
      });
    });
    super.dispose();
  }

  List<Widget> _screens = const [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return WillPopScope(
      onWillPop: () async {
        if (!isCollapsed) {
          setState(() {
            _controller.reverse();
            borderRadius = 0.0;
            isCollapsed = !isCollapsed;
          });
          return false;
        } else
          return true;
      },
      child: BlocProvider<MainScreenCubit>(
        create: (context) => MainScreenCubit(),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          resizeToAvoidBottomInset: false,
          body:Stack(
              children: <Widget>[
                menu(context),
                AnimatedPositioned(
                  left: isCollapsed ? 0 : 0.6 * screenWidth,
                  right: isCollapsed ? 0 : -0.2 * screenWidth,
                  top: isCollapsed ? 0 : screenHeight * 0.1,
                  bottom: isCollapsed ? 0 : screenHeight * 0.1,
                  duration: duration,
                  curve: Curves.fastOutSlowIn,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: BlocBuilder<MainScreenCubit, int>(
                            builder: (context, index) {
                          return Stack(
                            children: [
                              IndexedStack(
                                index: index,
                                children: [
                                  HomeScreen(),
                                  CredentialsScreen(),
                                  ContactUsScreen(),
                                  AboutScreen(),
                                  SettingsScreen(),
                                  CreateCredentialsScreen(),
                                  ProfileScreen(),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 28.0),
                                child: drawerIcon(),
                              ),
                            ],
                          );
                        }),
                      ),
                      // bottomNavBar(context),
                    ],
                  ),
                ),
              ],
            ),

          bottomNavigationBar: bottomNavBar(context),

        ),
      ),
    );
  }

  Widget menu(context) {
    return SafeArea(
      child: Container(
        color: Color(0xff2b2d42),
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.6,
              heightFactor: 0.8,
              child:
                  BlocBuilder<MainScreenCubit, int>(builder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CredentialsDrawerItem(
                      selected: index == 0,
                      title: 'home',
                      icon: Icons.home,
                      onTap: () {
                        context.read<MainScreenCubit>().onChangeDrawerTab(0);
                        Navigator.maybePop(context);
                      },
                    ),
                    CredentialsDrawerItem(
                      selected: index == 1,
                      title: 'Credentials',
                      icon: Icons.security,
                      onTap: () {
                        context.read<MainScreenCubit>().onChangeDrawerTab(1);
                        Navigator.maybePop(context);
                      },
                    ),
                    CredentialsDrawerItem(
                      selected: index == 2,
                      title: 'Contact Us',
                      icon: Icons.contact_mail,
                      onTap: () {
                        context.read<MainScreenCubit>().onChangeDrawerTab(2);
                        Navigator.maybePop(context);
                      },
                    ),
                    CredentialsDrawerItem(
                      selected: index == 3,
                      title: 'About',
                      icon: Icons.info,
                      onTap: () {
                        context.read<MainScreenCubit>().onChangeDrawerTab(3);
                        Navigator.maybePop(context);
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget drawerIcon() {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _controller,
      ),
      onPressed: () {
        setState(
          () {
            if (isCollapsed) {
              _controller.forward();

              borderRadius = 16.0;
            } else {
              _controller.reverse();

              borderRadius = 0.0;
            }

            isCollapsed = !isCollapsed;
          },
        );
      },
    );
  }

  Widget bottomNavBar(BuildContext context) {
    return Builder(
      builder: (context) {
        return Container(
          color: Theme.of(context).bottomAppBarColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: isCollapsed ? MainAxisSize.max : MainAxisSize.min,
            children: [
              ElevatedButton(
                  onPressed: () =>
                      context.read<MainScreenCubit>().onChangeDrawerTab(4),
                  child: Text('Settings')),
              FloatingActionButton(
                  onPressed: () =>
                      context.read<MainScreenCubit>().onChangeDrawerTab(5),
                  child: Icon(Icons.add)),
              ElevatedButton(
                  onPressed: () =>
                      context.read<MainScreenCubit>().onChangeDrawerTab(6),
                  child: Text('Profile')),
            ],
          ),
        );
      },
    );
  }
}
