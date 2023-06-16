// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/shared/cubit/states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark)
          .then((value) => emit(AppChangeModeState()));
    }
  }
}
