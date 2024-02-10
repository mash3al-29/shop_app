
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/LoginModel.dart';
import 'package:shop_app/models/LoginModel.dart';
import 'package:shop_app/modules/Login_Cubit/states.dart';
import 'package:shop_app/shared/network/EndPoints.dart';
import 'package:shop_app/shared/network/remote/Dio_Helper.dart';

class ShopLoginCubit extends Cubit<LoginStates>{

  ShopLoginCubit() : super(LoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

 void UserLogin(
     String email,
     String password,
     ) async {
   emit(LoginLoading());
   await DioHelper.PostData(
      url : LOGIN,
      data : {
        'email' : email,
        'password' : password,
      },
      ).then((value) {
     loginModel = LoginModel.fromjson(value.data);
     emit(LoginSuccsess(loginModel));
    }).catchError((dynamic error){
      print(error);
      emit(LoginError(error.toString()));
    });
  }

  bool isPasswordShown = true;
  IconData suffix = Icons.visibility_outlined;

  void Changepassandicon(){
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginPasswordStateChange());
  }

}