// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/home_layout_screen.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop/shared/bloc_observer.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/cubit/states.dart';
import 'package:shop/shared/network/local/cache_helper.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();

  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print(token);
  Widget widget;

  if (onBoarding != null) {
    if (token != null) {
      widget = HomeLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startScreen: widget,
    isDark: isDark,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  final bool? isDark;

  MyApp({
    super.key,
    required this.startScreen,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit()
              ..changeAppMode(
                fromShared: isDark,
              ),
          ),
          BlocProvider(
            create: (context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getUserData(),
          ),
        ],
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              home: startScreen,
            );
          },
        ));
  }
}
