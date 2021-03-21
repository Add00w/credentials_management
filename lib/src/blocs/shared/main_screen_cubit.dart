import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenCubit extends Cubit<int> {
  MainScreenCubit() : super(0);
  void onChangeDrawerTab(int index) => emit(index);
}
