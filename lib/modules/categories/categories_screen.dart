// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var categoryModel = ShopCubit.get(context).categoryModel;

        return ConditionalBuilder(
          condition: categoryModel != null,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                categoryItem(categoryModel.data!.categories[index], context),
            separatorBuilder: (context, index) => divider(),
            itemCount: categoryModel!.data!.categories.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget categoryItem(Category category, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(
                category.image!,
              ),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              category.name!,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );
}
