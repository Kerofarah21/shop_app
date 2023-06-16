// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:shop/models/change_favorites_model.dart';
import 'package:shop/models/login_model.dart';

abstract class ShopStates {}

class ShopInitState extends ShopStates {}

class ShopChangeBootomNavState extends ShopStates {}

class ShopHomeSuccessState extends ShopStates {}

class ShopHomeErrorState extends ShopStates {
  final String error;

  ShopHomeErrorState(this.error);
}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopCategoriesErrorState extends ShopStates {
  final String error;

  ShopCategoriesErrorState(this.error);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopChangeFavoritesSuccessState extends ShopStates {
  final ChangeFavoritesModel changeFavoritesModel;

  ShopChangeFavoritesSuccessState(this.changeFavoritesModel);
}

class ShopChangeFavoritesErrorState extends ShopStates {
  final String error;

  ShopChangeFavoritesErrorState(this.error);
}

class ShopFavoritesLoadingState extends ShopStates {}

class ShopFavoritesSuccessState extends ShopStates {}

class ShopFavoritesErrorState extends ShopStates {
  final String error;

  ShopFavoritesErrorState(this.error);
}

class ShopUserDataSuccessState extends ShopStates {}

class ShopUserDataErrorState extends ShopStates {
  final String error;

  ShopUserDataErrorState(this.error);
}

class ShopUpdateUserDataLoadingState extends ShopStates {}

class ShopUpdateUserDataSuccessState extends ShopStates {
  final LoginModel loginModel;

  ShopUpdateUserDataSuccessState(this.loginModel);
}

class ShopUpdateUserDataErrorState extends ShopStates {
  final String error;

  ShopUpdateUserDataErrorState(this.error);
}
