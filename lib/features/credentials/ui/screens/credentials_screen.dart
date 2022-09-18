import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/circular_loading.dart';
import '../../bloc/credentials_cubit.dart';
import '../widgets/credential_widget.dart';
import '../widgets/no_credentials.dart';

class CredentialsScreen extends StatelessWidget {
  const CredentialsScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CredentialsCubit, CredentialsState>(
        bloc: context.read<CredentialsCubit>()..getCredentials(),
        builder: (context, state) {
          return state is CredentialsLoaded
              ? state.credentials.isEmpty
                  ? const NoCrededentialsWidget()
                  : ListView.builder(
                      itemCount: state.credentials.length,
                      itemBuilder: (_, index) {
                        return CredentialWidget(
                          credential: state.credentials[index],
                        );
                      },
                    )
              : CircularLoading();
        },
      ),
    );
  }
}
