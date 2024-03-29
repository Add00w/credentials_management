import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './drawer_icon.dart';
import '../main_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isCollapsed = context.watch<DrawerIconCubit>().state;

    return Container(
      color: const Color(0xff2b2d42),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: isCollapsed ? MainAxisSize.max : MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () => _goToPage(context, 0),
            child: const Text('Home'),
          ),
          FloatingActionButton(
            onPressed: () => _goToPage(context, 1),
            child: const Icon(Icons.add),
          ),
          ElevatedButton(
            onPressed: () => _goToPage(context, 2),
            child: const Text('Profile'),
          ),
        ],
      ),
    );
  }

  void _goToPage(BuildContext context, int index) {
    context.read<MainScreenCubit>().onChangeDrawerTab(index);
    Navigator.maybePop(context);
  }
}
