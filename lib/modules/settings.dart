import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'Shop_Login_Screen.dart';

class Settings_Screen extends StatelessWidget {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state) {},
      builder: (context,state) {
        if(ShopCubit.get(context).UserDataProfile != null){
          namecontroller.text = ShopCubit.get(context).UserDataProfile.data.name ;
          phonecontroller.text = ShopCubit.get(context).UserDataProfile.data.phone ;
          emailcontroller.text = ShopCubit.get(context).UserDataProfile.data.email ;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultTextFormField(
                  controller: namecontroller,
                  type: TextInputType.name,
                  LabelText: 'Name',
                  prefixicon: Icons.person,
                  color: Colors.purple[400],
                  validate: (value){
                    if(value.isEmpty()){
                      return 'Name Must Not Be Empty!';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultTextFormField(
                  controller: emailcontroller,
                  type: TextInputType.emailAddress,
                  LabelText: 'Email',
                  prefixicon: Icons.email,
                  color: Colors.purple[400],
                  validate: (value){
                    if(value.isEmpty()){
                      return 'E-Mail Must Not Be Empty!';
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DefaultTextFormField(
                  controller: phonecontroller,
                  type: TextInputType.phone,
                  LabelText: 'Phone',
                  prefixicon: Icons.phone,
                  color: Colors.purple[400],
                  validate: (value){
                    if(value.isEmpty()){
                      return 'Phone Must Not Be Empty!';
                    }
                  },
                ),
              ),
              SizedBox(height: 20,),
              DefaultButton(
                function: (){
                  CacheHelper.sharedPreferences.remove('token').then((value) {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Shop_Login_Screen()), (route) => false);
                  });
                },
                radius: 10,
                width: 375,
                text: 'Sign Out',
                color: Colors.purple[400],
                textColor: Colors.white,
              ),
            ],
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
        },
    );
  }
}
