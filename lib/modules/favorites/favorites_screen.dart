// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var favoritesModel = ShopCubit.get(context).favoritesModel;

        return ConditionalBuilder(
          condition: favoritesModel!.data!.favorites.isNotEmpty,
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => productItem(
                favoritesModel.data!.favorites[index].product!, context),
            separatorBuilder: (context, index) => divider(),
            itemCount: favoritesModel.data!.favorites.length,
          ),
          fallback: (context) => emptyFavorites(),
        );
      },
    );
  }

  Widget productItem(Product product, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120.0,
          child: Row(
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(
                      product.image!,
                    ),
                    width: 120.0,
                    height: 120.0,
                  ),
                  if (product.discount != 0)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      color: Colors.red,
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
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
                    Row(
                      children: [
                        Text(
                          '${product.price.round()}',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: defaultColor,
                          ),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        if (product.discount != 0)
                          Text(
                            '${product.oldPrice.round()}',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(product.id);
                          },
                          icon: Icon(
                            ShopCubit.get(context).favorites[product.id]!
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: defaultColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  Widget emptyFavorites() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite,
              color: Colors.grey,
              size: 100.0,
            ),
            Text(
              'No Favorites added',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
}
