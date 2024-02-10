import 'package:shop_app/models/LoginModel.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginSuccsess extends LoginStates{

  final LoginModel loginModel;

  LoginSuccsess(this.loginModel);

}

class LoginLoading extends LoginStates{}

class LoginError extends LoginStates{
  final String error;
  LoginError(this.error);
}

class LoginPasswordStateChange extends LoginStates{}