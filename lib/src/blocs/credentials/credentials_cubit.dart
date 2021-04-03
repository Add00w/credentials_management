import 'package:bloc/bloc.dart';
import 'package:credentials_management/src/common/utils.dart';
import 'package:credentials_management/src/models/credentials.dart';
import 'package:credentials_management/src/services/repositories/credentials_repository.dart';
import 'package:equatable/equatable.dart';

part 'credentials_state.dart';

class CredentialsCubit extends Cubit<CredentialsState> {
  CredentialsCubit(this.credentialsRepository) : super(CredentialsInitial());
  final CredentialsRepository credentialsRepository;
  Future<void> createCredentials(Credentials credential) async {
    final icon = await Utils.getCompanyLogo(credential.email);
    credential.icon = icon;
    credentialsRepository.add(credential).then((index) {});
  }
}
