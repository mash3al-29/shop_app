import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/Salla_Layout.dart';
import 'package:shop_app/modules/Login_Cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'Login_Cubit/cubit.dart';

class Shop_Login_Screen extends StatelessWidget {
var EmailController = TextEditingController();
var PasswordController = TextEditingController();
var FormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)  => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,LoginStates>(
        listener: (context,state) {
          if(state is LoginSuccsess)
          {
            if(state.loginModel.status == true){
              DefaultToast(message: state.loginModel.message, fontsize: 16,Backgroundcolor: Colors.green);
              CacheHelper.PutData(key: 'token', value: state.loginModel.data.token).then((value) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SallaLayout()), (route) => false);
              });
            }else{
              DefaultToast(message: state.loginModel.message, fontsize: 16,Backgroundcolor: Colors.amber);
            }
          }else if(state is LoginError){
            DefaultToast(message: "Something went wrong! Please Try Again Later", fontsize: 13,Backgroundcolor: Colors.red);
          }
        },
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: FormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontFamily: 'Baloo5',
                              fontSize: 30
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Login To See Our Hot Offers!',
                          style: TextStyle(
                            fontFamily: 'Baloo5',
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 50,),
                        DefaultTextFormField(
                          controller: EmailController,
                          prefixicon:Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          LabelText: 'E-Mail Address',
                          validate:(dynamic value){
                            if(value.isEmpty){
                              return('Please Enter a valid E-Mail!');
                            }
                          },
                        ),
                        SizedBox(height: 30,),
                        DefaultTextFormField(
                          controller: PasswordController,
                          prefixicon:Icons.lock_outline,
                          type: TextInputType.visiblePassword,
                          SubmitFunction: (value){
                            if(FormKey.currentState.validate()) {
                              ShopLoginCubit.get(context).UserLogin(
                                EmailController.text,
                                PasswordController.text,
                              );}
                          },
                          LabelText: 'Password',
                          isObscure: ShopLoginCubit.get(context).isPasswordShown,
                          SufixIcon: ShopLoginCubit.get(context).suffix,
                          isSuffixpressed: (){
                            return ShopLoginCubit.get(context).Changepassandicon();
                          },
                          validate:(dynamic value){
                            if(value.isEmpty){
                              return('Please Enter a valid Password!');
                            }
                          },
                        ),
                        SizedBox(height: 30,),
                        ConditionalBuilder(
                            condition: state is !LoginLoading,
                            builder: (context) => DefaultButton(
                              function: (){
                                if(FormKey.currentState.validate()) {
                                  ShopLoginCubit.get(context).UserLogin(
                                    EmailController.text,
                                    PasswordController.text,
                                  );
                                }},
                              text: 'LOGIN',
                              color:Colors.purple[400],
                              radius: 10,
                            ) ,
                          fallback: (context) { return Center(child: CircularProgressIndicator());},
                        ),
                        SizedBox(height: 30,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't Have An Account?",style: TextStyle(fontSize: 15),),
                            TextButton(
                                onPressed: (){},
                                child: Text('Register Now!',style: TextStyle(fontWeight: FontWeight.bold),)
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
