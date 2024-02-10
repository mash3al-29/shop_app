import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/modules/Shop_Login_Screen.dart';
import 'package:shop_app/modules/search.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import 'cubit/states.dart';

class SallaLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Shop App',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: 'Baloo5',
                  color: Colors.white
              ),
            ),
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Search_Screen()));
                }, icon: Icon(
                    Icons.search,
                  color: Colors.white,
                ),
              ),
            ],
            centerTitle: true,
          ),
          body: ShopCubit.get(context).pages[ShopCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Products'),
              BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favourites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
            ],
            currentIndex: ShopCubit.get(context).currentIndex,
            onTap: (index){
              ShopCubit.get(context).ChangeBottomNav(index);
            },

          )
          ,
        );
      },
    );
  }
}
