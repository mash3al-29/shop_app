import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/Dio_Helper.dart';
import 'package:shop_app/shared/styles/themes.dart';

import 'Bloc_Observer.dart';
import 'layout/Salla_Layout.dart';
import 'layout/cubit/cubit.dart';
import 'modules/Shop_Login_Screen.dart';
import 'modules/on_boarding_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool onBoarding = CacheHelper.GetData(key: 'OnBoarding');
  String token = CacheHelper.GetData(key: 'token');

  Widget ChooseStartScreen(){
  if(onBoarding != null){
    if(token != null){
      return SallaLayout();
    }else{
      return Shop_Login_Screen();
    }
  }else{
    return On_Boarding_Screen();
  }
  }
  Widget startwidget = ChooseStartScreen();

  runApp(MyApp(startwidget));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Widget startWidget;
  MyApp(
      this.startWidget
      );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopCubit()..GetProducts()..GetCategories()..GetFavorites()..GetUserData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:startWidget,
        theme: LightTheme,
        darkTheme: DarkTheme,
        themeMode: ThemeMode.light,
      ),
    );
  }
}

