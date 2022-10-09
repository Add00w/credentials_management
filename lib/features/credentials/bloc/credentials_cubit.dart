import 'dart:developer' show log;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/credentials.dart';
import '../repository/credentials_repository.dart';

part 'credentials_state.dart';

class CredentialsCubit extends Cubit<CredentialsState> {
  CredentialsCubit(this.credentialsRepository) : super(CredentialsInitial());
  final CredentialsRepository credentialsRepository;

  void createCredentials(Credentials credential) {
    emit(AddCredentialInProgress());
    credentialsRepository.add(credential).then((index) {
      emit(CredentialsAdded());
    });
  }

  void delete(String id, int index) {
    final credentials = (state as CredentialsLoaded).credentials;
    emit(CredentialsDeleteInProgress());
    try {
      credentialsRepository.delete(index, id).then((_) {
        credentials.removeAt(index);
        emit(CredentialsLoaded(credentials));
      });
    } catch (e) {
      log('error:$e');
    }
  }

  void edit(String id, int index, Credentials crdential) {
    emit(CredentialsEditInProgress());
    try {
      credentialsRepository.edit(crdential, index, id).then(
        (_) {
          emit(CredentialsEdited());
        },
      );
    } catch (e) {
      log('error:$e');
    }
  }

  void getCredentials() {
    if (state is! CredentialsLoaded) {
      emit(CredentialsLoading());
      try {
        credentialsRepository.getCredentials().then((credentials) {
          emit(CredentialsLoaded(credentials));
        });
      } catch (e) {
        log('error:$e');
      }
    }
  }
}
