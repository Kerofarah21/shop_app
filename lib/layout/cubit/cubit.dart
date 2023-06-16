// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/models/change_favorites_model.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/models/login_model.dart';
import 'package:shop/modules/categories/categories_screen.dart';
import 'package:shop/modules/favorites/favorites_screen.dart';
import 'package:shop/modules/products/products_screen.dart';
import 'package:shop/modules/settings/settings_screen.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;
  void changeIndex(index) {
    currentIndex = index;
    emit(ShopChangeBootomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel(value.data);
      homeModel!.data!.products!.forEach((product) => favorites.addAll({
            product.id!: product.inFavorites!,
          }));
      emit(ShopHomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopHomeErrorState(error.toString()));
    });
  }

  CategoryModel? categoryModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoryModel = CategoryModel(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopCategoriesErrorState(error.toString()));
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(productID) {
    favorites[productID] = !favorites[productID]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productID,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productID] = !favorites[productID]!;
      } else {
        getFavoritesData();
      }
      emit(ShopChangeFavoritesSuccessState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productID] = !favorites[productID]!;
      print(error.toString());
      emit(ShopChangeFavoritesErrorState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(ShopFavoritesLoadingState());

    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel(value.data);
      emit(ShopFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopFavoritesErrorState(error.toString()));
    });
  }

  LoginModel? userModel;

  void getUserData() {
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      emit(ShopUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopUserDataErrorState(error.toString()));
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopUpdateUserDataLoadingState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      UserData? userData = userModel!.data;
      userModel = LoginModel.fromJson(value.data);
      if (!LoginModel.fromJson(value.data).status!) {
        userModel!.data = userData;
      }
      emit(ShopUpdateUserDataSuccessState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopUpdateUserDataErrorState(error.toString()));
    });
  }
}
