import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/bloc/auth_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.authenticationBloc,
  }) : super(ProfileInitial());
  final AuthenticationBloc authenticationBloc;

  void profile() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      log('How did you reached the profile');
    } else {
      emit(ProfileLoaded(user: user));
    }
  }
}
