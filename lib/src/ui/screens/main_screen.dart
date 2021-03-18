import 'package:credentials_management/src/ui/screens/about_screen.dart';
import 'package:credentials_management/src/ui/screens/contact_screen.dart';
import 'package:credentials_management/src/ui/screens/credentials/credentials_screen.dart';
import 'package:credentials_management/src/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

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
  int _screenIdex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
  }

  @override
  void dispose() {
    _controller.dispose();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {
        _navBarIndex = tabController.index;
      });
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = const [
      HomeScreen(),
      CredentialsScreen(),
      ContactUsScreen(),
      AboutScreen()
    ];
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
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: <Widget>[
            menu(context),
            backgroundWidget(context),
            AnimatedPositioned(
              left: isCollapsed ? 0 : 0.6 * screenWidth,
              right: isCollapsed ? 0 : -0.2 * screenWidth,
              top: isCollapsed ? 0 : screenHeight * 0.1,
              bottom: isCollapsed ? 0 : screenHeight * 0.1,
              duration: duration,
              curve: Curves.fastOutSlowIn,
              child: home(),
            ),
          ],
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0.0,
                    leading: Icon(Icons.home),
                    title: Text(
                      'Home',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0.0,
                    leading: Icon(Icons.security),
                    title: Text(
                      'Credentials',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0.0,
                    leading: Icon(Icons.contact_mail),
                    title: Text(
                      'Contact Us',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0.0,
                    leading: Icon(Icons.info),
                    title: Text(
                      'About',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget home() {
    return SafeArea(
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
        type: MaterialType.card,
        animationDuration: duration,
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 8,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.exit_to_app),
            ),
            appBar: AppBar(
              title: Text('Dashboard'),
              leading: IconButton(
                  icon: AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _controller,
                  ),
                  onPressed: () {
                    setState(() {
                      if (isCollapsed) {
                        _controller.forward();

                        borderRadius = 16.0;
                      } else {
                        _controller.reverse();

                        borderRadius = 0.0;
                      }

                      isCollapsed = !isCollapsed;
                    });
                  }),
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius)),
              child: BottomNavigationBar(
                  currentIndex: _navBarIndex,
                  type: BottomNavigationBarType.shifting,
                  onTap: (index) {
                    setState(() {
                      _navBarIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.dashboard),
                      label: '.',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.explore),
                      label: '.',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.notifications),
                      label: '.',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle),
                      label: '.',
                    ),
                  ]),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 50),
                    Container(
                      height: 200,
                      child: PageView(
                        controller: PageController(viewportFraction: 0.8),
                        scrollDirection: Axis.horizontal,
                        pageSnapping: true,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            color: Colors.redAccent,
                            width: 100,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            color: Colors.blueAccent,
                            width: 100,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            color: Colors.greenAccent,
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget backgroundWidget(BuildContext context) {
    return AnimatedPositioned(
      left: isCollapsed ? 0 : 0.57 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      top: isCollapsed ? 0 : screenHeight * 0.1,
      bottom: isCollapsed ? 0 : screenHeight * 0.1,
      duration: duration,
      curve: Curves.fastOutSlowIn,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(isCollapsed ? 10 : 65),
            color: Theme.of(context).backgroundColor,
          ),
          child: Column(
            children: [
              Row(
                children: [],
              )
            ],
          )),
    );
  }
}
