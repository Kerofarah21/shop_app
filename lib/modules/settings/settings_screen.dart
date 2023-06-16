// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/cubit/cubit.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopUpdateUserDataSuccessState) {
          if (state.loginModel.status!) {
            showToast(
              message: state.loginModel.message!,
              state: ToastState.SUCCESS,
            );
          } else {
            showToast(
              message: state.loginModel.message!,
              state: ToastState.ERROR,
            );
          }
        }
      },
      builder: (context, state) {
        var userModel = ShopCubit.get(context).userModel;

        nameController.text = userModel!.data!.name!;
        emailController.text = userModel.data!.email!;
        phoneController.text = userModel.data!.phone!;

        return ConditionalBuilder(
          condition: userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  ConditionalBuilder(
                    condition: state is! ShopUpdateUserDataLoadingState,
                    builder: (context) => Column(
                      children: [
                        defaultFormField(
                          context,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          label: 'Name',
                          prefix: Icons.person,
                          validator: (value) {
                            if (value!.isEmpty) return 'name must not be empty';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          context,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'email must not be empty';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          context,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty)
                              return 'phone must not be empty';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                    fallback: (context) => LinearProgressIndicator(),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dark Mode',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Switch.adaptive(
                        value: AppCubit.get(context).isDark,
                        onChanged: (value) {
                          AppCubit.get(context).changeAppMode();
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    text: 'update',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    onPressed: () {
                      CacheHelper.removeData(key: 'token').then((value) {
                        if (value) navigateAndFinish(context, LoginScreen());
                      });
                    },
                    text: 'logout',
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
