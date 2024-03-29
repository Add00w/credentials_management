import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main/main_cubit.dart';

class NoCrededentialsWidget extends StatelessWidget {
  const NoCrededentialsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Empty'),
          const SizedBox(height: 8.0),
          IconButton(
            tooltip: 'Click here to add one',
            onPressed: () {
              context.read<MainScreenCubit>().onChangeDrawerTab(1);
            },
            icon: const Icon(Icons.enhanced_encryption_rounded),
          ),
        ],
      ),
    );
  }
}
