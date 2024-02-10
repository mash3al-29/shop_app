import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Salla_Layout.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/Login_Cubit/states.dart';
import 'package:shop_app/modules/Shop_Login_Screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'Login_Cubit/cubit.dart';

class Register_Screen extends StatelessWidget {

  var EmailController = TextEditingController();

  var PasswordController = TextEditingController();

  var NameController = TextEditingController();

  var PhoneController = TextEditingController();

  var FormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopLoginCubit,LoginStates>(
      listener: (context,state) {
        if(state is RegisterSucses){
          if(ShopLoginCubit.get(context).RegisterModel.status == true){
            DefaultToast(
              message: ShopLoginCubit.get(context).RegisterModel.message,
              Backgroundcolor: Colors.green,
              fontsize: 14,
            );
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Shop_Login_Screen()), (route) => false);
          }else{
            DefaultToast(
              message: ShopLoginCubit.get(context).RegisterModel.message,
              Backgroundcolor: Colors.amber,
              fontsize: 14,
            );
          }
        }else if(state is RegisterErrorhaha){
          DefaultToast(
            message: 'Something Went Wrong! Please Try Again Later!',
            Backgroundcolor: Colors.red,
            fontsize: 14,
          );
        }
      },
      builder: (context,state) {
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
                        'SIGN UP',
                        style: TextStyle(
                            fontFamily: 'Baloo5',
                            fontSize: 30
                        ),
                      ),
                      Text(
                        'Login To See Our Hot Offers!',
                        style: TextStyle(
                          fontFamily: 'Baloo5',
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        'Sign Up To See Our Hot Offers!',
                        style: TextStyle(
                          fontFamily: 'Baloo5',
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 50,),
                      DefaultTextFormField(
                        controller: NameController,
                        prefixicon:Icons.person,
                        type: TextInputType.text,
                        LabelText: 'Name',
                        validate:(dynamic value){
                          if(value.isEmpty){
                            return('Name Must Not Be Empty');
                          }
                        },
                      ),
                      SizedBox(height: 30,),
                      DefaultTextFormField(
                        controller: EmailController,
                        prefixicon:Icons.email,
                        type: TextInputType.emailAddress,
                        LabelText: 'E-Mail',
                        validate:(dynamic value){
                          if(value.isEmpty){
                            return('Please Enter a valid Email!');
                          }
                        },
                      ),
                      SizedBox(height: 30,),
                      DefaultTextFormField(
                        controller: PhoneController,
                        prefixicon:Icons.phone,
                        type: TextInputType.phone,
                        LabelText: 'Phone',
                        validate:(dynamic value){
                          if(value.isEmpty){
                            return('Phone Number Must Not Be Empty');
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
                            ShopLoginCubit.get(context).RegisterUser(
                              name: NameController.text,
                              email: EmailController.text,
                              phone: PhoneController.text,
                              password: PasswordController.text,
                            );
                          }
                        },
                        LabelText: 'Password',
                        isObscure: ShopLoginCubit.get(context).isPasswordShownRegister,
                        SufixIcon: ShopLoginCubit.get(context).suffixRegsiter,
                        isSuffixpressed: (){
                          return ShopLoginCubit.get(context).ChangepassandiconRegister();
                        },
                        validate:(dynamic value){
                          if(value.isEmpty){
                            return('Password Must Not Be Empty and 6 characters long!');
                          }
                        },
                      ),
                      SizedBox(height: 30,),

                  if(state is RegisterLoading)
                   Center(child: CircularProgressIndicator())
                      else DefaultButton(
                    function: (){
                      if(FormKey.currentState.validate()){
                        ShopLoginCubit.get(context).RegisterUser(
                          name: NameController.text,
                          email: EmailController.text,
                          phone: PhoneController.text,
                          password: PasswordController.text,
                        );
                      }
                    },
                    text: 'SIGN UP',
                    color:Colors.purple[400],
                    radius: 10,
                  ),
                      SizedBox(height: 30,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },

    );
  }
}
