import 'package:credentials_management/src/blocs/credentials/credentials_cubit.dart';
import 'package:credentials_management/src/ui/widgets/circular_loading.dart';
import 'package:credentials_management/src/ui/widgets/credential_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CredentialsScreen extends StatefulWidget {
  @override
  _CredentialsState createState() => _CredentialsState();
}

class _CredentialsState extends State<CredentialsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CredentialsCubit, CredentialsState>(
        bloc: context.read<CredentialsCubit>()..getCredentials(),
        builder: (context, state) {
          return state is CredentialsLoaded
              ? ListView.builder(
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
