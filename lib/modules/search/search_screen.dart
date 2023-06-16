// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/search_model.dart';
import 'package:shop/modules/search/cubit/cubit.dart';
import 'package:shop/modules/search/cubit/states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/colors.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          if (state is SearchSuccessState) {
            if (state.searchModel.data!.products.isEmpty) {
              showToast(
                message: 'No Products Found',
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var searchModel = SearchCubit.get(context).searchModel;

          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    context,
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    label: 'Search',
                    prefix: Icons.search,
                    onSubmit: (value) {
                      SearchCubit.get(context).search(
                        text: value,
                      );
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: Container(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => productItem(
                            searchModel.data!.products[index],
                            context,
                          ),
                          separatorBuilder: (context, index) => divider(),
                          itemCount: searchModel!.data!.products.length,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget productItem(Product product, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Image(
                image: NetworkImage(
                  product.image!,
                ),
                width: 120.0,
                height: 120.0,
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            height: 1.3,
                          ),
                    ),
                    Spacer(),
                    Text(
                      '${product.price.round()}',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
