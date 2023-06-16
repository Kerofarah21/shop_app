// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/category_model.dart';
import 'package:shop/models/home_model.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavoritesSuccessState) {
          if (!state.changeFavoritesModel.status!) {
            showToast(
              message: state.changeFavoritesModel.message!,
              state: ToastState.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        var homeModel = ShopCubit.get(context).homeModel;
        var categoryModel = ShopCubit.get(context).categoryModel;

        return ConditionalBuilder(
          condition: homeModel != null && categoryModel != null,
          builder: (context) => homeBuilder(homeModel, categoryModel, context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget homeBuilder(
          HomeModel? homeModel, CategoryModel? categoryModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel!.data!.banners!
                  .map((banner) => Image(
                        width: double.infinity,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          banner.image ?? '',
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200.0,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 9),
                autoPlayAnimationDuration: Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          categoryItem(categoryModel.data!.categories[index]),
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 10.0),
                      itemCount: categoryModel!.data!.categories.length,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 1.0,
              mainAxisSpacing: 1.0,
              childAspectRatio: 1 / 1.58,
              children: List.generate(
                homeModel.data!.products!.length,
                (index) =>
                    productItem(homeModel.data!.products![index], context),
              ),
            ),
          ],
        ),
      );

  Widget productItem(Product product, context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                width: double.infinity,
                height: 200.0,
                color: Colors.white,
                child: Image(
                  image: NetworkImage(
                    product.image!,
                  ),
                  width: double.infinity,
                  height: 200.0,
                ),
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        height: 1.3,
                      ),
                ),
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
      );

  Widget categoryItem(Category category) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(
              category.image!,
            ),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: 100.0,
            child: Text(
              category.name!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      );
}
