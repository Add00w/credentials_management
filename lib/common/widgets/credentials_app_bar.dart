import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/main/main_cubit.dart';
import '../../features/main/widgets/drawer_icon.dart';

class CredentialsAppBar extends StatelessWidget {
  const CredentialsAppBar({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenCubit, int>(
      builder: (context, index) {
        return AppBar(
          title: Text(_changeTitle(index)),
          automaticallyImplyLeading: false,
          leading: const DrawerIcon(),
          elevation: 0.0,
          backgroundColor: const Color(0xff2b2d42),
        );
      },
    );
  }

  String _changeTitle(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Create Credentials';
      case 2:
        return 'Profile';
      case 3:
        return 'Credentials';
      default:
        throw RangeError('Out of range');
    }
  }
}
