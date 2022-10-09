import 'package:credentials_management/features/credentials/ui/screens/edit_credentials_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

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
                        final currentCredential = state.credentials[index];
                        return Slidable(
                          key: Key(currentCredential.id ?? '$index'),
                          startActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const DrawerMotion(),

                            // A pane can dismiss the Slidable.
                            dismissible: DismissiblePane(
                              onDismissed: () {
                                context
                                    .read<CredentialsCubit>()
                                    .delete(currentCredential.id!, index);
                              },
                            ),

                            // All actions are defined in the children parameter.
                            children: [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                onPressed: (context) {
                                  context
                                      .read<CredentialsCubit>()
                                      .delete(currentCredential.id!, index);
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                              SlidableAction(
                                onPressed: (context) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditCredentialsScreen(
                                        index: index,
                                        credentials: currentCredential,
                                      ),
                                    ),
                                  );
                                },
                                backgroundColor: const Color(0xFF21B7CA),
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                            ],
                          ),
                          child: CredentialWidget(
                            credential: currentCredential,
                          ),
                        );
                      },
                    )
              : CircularLoading();
        },
      ),
    );
  }
}
