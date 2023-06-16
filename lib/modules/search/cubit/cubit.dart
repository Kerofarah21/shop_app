// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/modules/search/cubit/states.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/remote/dio_helper.dart';
import 'package:shop/shared/network/remote/end_points.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void search({
    required String text,
  }) {
    emit(SearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    ).then((value) {
      searchModel = SearchModel(value.data);
      emit(SearchSuccessState(searchModel!));
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
