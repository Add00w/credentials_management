import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './credentials_drawer_item.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../main_cubit.dart';

class CredentialsDrawer extends StatelessWidget {
  const CredentialsDrawer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xff2b2d42),
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.6,
              heightFactor: 0.8,
              child: BlocBuilder<MainScreenCubit, int>(
                builder: (context, index) {
                  return Column(
                    // mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CredentialsDrawerItem(
                        selected: index == 3,
                        title: 'Credentials',
                        icon: Icons.security,
                        onTap: () => _goToPage(context, 3),
                      ),
                      const SizedBox(height: 8.0),
                      CredentialsDrawerItem(
                        selected: false,
                        title: 'Logout',
                        icon: Icons.logout,
                        onTap: () {
                          context.read<AuthenticationBloc>().add(LoggedOut());
                          Navigator.maybePop(context);
                        },
                      ),
                      const Spacer(),
                      const AboutListTile(),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _goToPage(BuildContext context, int index) {
    context.read<MainScreenCubit>().onChangeDrawerTab(index);
    Navigator.maybePop(context);
  }
}
