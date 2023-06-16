// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultTextButton({
  required VoidCallback onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField(
  context, {
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String? label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isPassword = false,
  String? Function(String?)? validator,
  VoidCallback? onTap,
  Function(String)? onChange,
  Function(String)? onSubmit,
}) =>
    TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(
          prefix,
        ),
        prefixIconColor: Colors.grey,
        suffixIcon: IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        ),
        suffixIconColor: Colors.grey,
      ),
      style: Theme.of(context).textTheme.bodyLarge,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: validator,
      onTap: onTap,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
    );

Widget defaultButton({
  required VoidCallback? onPressed,
  required String text,
  double width = double.infinity,
  bool isUpperCase = true,
  double radius = 10.0,
  Color backgroundColor = Colors.deepPurple,
}) =>
    Container(
      width: width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: backgroundColor,
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );
}

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false,
  );
}

enum ToastState {
  SUCCESS,
  ERROR,
  WARNING,
}

Color chooseColor(ToastState state) {
  switch (state) {
    case ToastState.SUCCESS:
      return Colors.green;
    case ToastState.ERROR:
      return Colors.red;
    case ToastState.WARNING:
      return Colors.amber;
  }
}

void showToast({
  required String message,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

Widget divider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 1,
        color: Colors.grey,
      ),
    );
