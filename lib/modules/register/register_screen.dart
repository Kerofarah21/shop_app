// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/home_layout_screen.dart';
import 'package:shop/modules/login/login_screen.dart';
import 'package:shop/modules/register/cubit/cubit.dart';
import 'package:shop/modules/register/cubit/states.dart';
import 'package:shop/shared/components/components.dart';
import 'package:shop/shared/components/constants.dart';
import 'package:shop/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.loginModel.status == true) {
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token,
              ).then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(context, HomeLayout());
              });
            } else {
              showToast(
                message: state.loginModel.message!,
                state: ToastState.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var registerCubit = RegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        defaultFormField(
                          context,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          label: 'User Name',
                          prefix: Icons.person,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          context,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          context,
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: registerCubit.suffix,
                          suffixPressed: () {
                            registerCubit.changePasswordVisibility();
                          },
                          isPassword: registerCubit.isPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          context,
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter your phone';
                            }
                            return null;
                          },
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              registerCubit.userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => defaultButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                registerCubit.userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'have an account?',
                            ),
                            defaultTextButton(
                              onPressed: () {
                                navigateTo(context, LoginScreen());
                              },
                              text: 'login',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
