import 'package:shop/models/login_model.dart';

abstract class RegisterStates {}

class RegisterInitState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {
  LoginModel loginModel;

  RegisterSuccessState(this.loginModel);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class RegisterPasswordVisibilityState extends RegisterStates {}
