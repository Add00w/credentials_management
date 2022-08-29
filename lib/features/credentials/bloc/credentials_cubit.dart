import 'dart:developer' show log;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/credentials.dart';
import '../repository/credentials_repository.dart';

part 'credentials_state.dart';

class CredentialsCubit extends Cubit<CredentialsState> {
  CredentialsCubit(this.credentialsRepository) : super(CredentialsInitial());
  final CredentialsRepository credentialsRepository;
  Future<void> createCredentials(Credentials credential) async {
    emit(AddCredentialInProgress());
    credentialsRepository.add(credential).then((index) {
      log('current added index:$index');
      emit(CredentialsAdded());
    });
  }

  Future<void> getCredentials() async {
    if (state is! CredentialsLoaded) {
      emit(CredentialsLoading());
      try {
        credentialsRepository.getCredentials().then((credentials) {
          log('credentials:${credentials.length.toString()}');
          emit(CredentialsLoaded(credentials));
        });
      } catch (e) {
        log('error:$e');
      }
    }
  }
}
