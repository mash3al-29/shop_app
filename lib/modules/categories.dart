import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/CategoriesModel.dart';

class Categories_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: ShopCubit.get(context).categoriesModel != null ?
            (context,state) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
          itemBuilder: (context,index) =>  BuildCategoriesItems(ShopCubit.get(context).categoriesModel,index),
          separatorBuilder: (context,index) => Container(
            width: double.infinity,
            height:1,
            color: Colors.grey[300],
          ),
          itemCount: ShopCubit.get(context).categoriesModel.data.categories.length,
        );} : Center(child: CircularProgressIndicator()),
        listener: (context,state) {},
    );
  }

  Widget BuildCategoriesItems(CategoriesModel model,int index){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.data.categories[index].image),
            height: 120,
            width: 120,
            fit: BoxFit.fill,
          ),
          SizedBox(width: 12,),
          Text(
            model.data.categories[index].name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple[400],
            ),

          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios,size: 30,),
        ],
      ),
    );
  }
}
