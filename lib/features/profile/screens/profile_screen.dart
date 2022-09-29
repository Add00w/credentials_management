import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/bloc/auth_bloc.dart';
import '../cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen();
  @override
  Widget build(BuildContext context) {
    final state = context.read<ProfileCubit>().state;
    if (state is ProfileLoaded) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const CircleAvatar(),
                  const SizedBox(width: 24),
                  Column(
                    children: [
                      Text(
                        state.user.displayName ?? '',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(height: 8),
                      Text(state.user.email ?? ''),
                    ],
                  )
                ],
              ),
            ),
            const Divider(),
            TextButton.icon(
              onPressed: () {
                context.read<AuthenticationBloc>().add(LoggedOut());
              },
              icon: const Icon(Icons.logout),
              label: const Text('Log out'),
            ),
          ],
        ),
      );
    }
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
