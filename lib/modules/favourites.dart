import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/GetOmElFavorites.dart';
import 'package:shop_app/models/Products_Model.dart';
import 'package:shop_app/shared/components/components.dart';

class Favourites_Screen extends StatelessWidget {

  Widget FavScreenWidgetsBuilder(ProductData model,context){
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage(model.product.image),
                  width: 120,
                  height: 120,
                ),
                if(model.product.discount != 0)
                  Text('DISCOUNT',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      backgroundColor: Colors.red,
                    ),),
              ],
              alignment: AlignmentDirectional.bottomStart,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Expanded(
                    child: Text(
                      model.product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          '${model.product.price.round()}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.purple[400],
                            height: 0.8,
                            fontSize: 16,
                          )),
                      SizedBox(width: 10,),
                      if(model.product.discount != 0)  Text(
                          '${model.product.oldPrice.round()}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey[500],
                            height: 0.8,
                            fontSize: 16,
                          )),
                      Spacer(),
                      Container(
                        height: 60,
                        child: IconButton(
                          icon: CircleAvatar(
                            radius: 45,
                            backgroundColor: ShopCubit.get(context).Favourites[model.product.id] == null ? Colors.purple[400] : ShopCubit.get(context).Favourites[model.product.id] ? Colors.purple[400] :  Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: (){
                            ShopCubit.get(context).ChangeFavourites(model.product.id);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ChangeFavouritesStatusFalseShop){
          DefaultToast(
            message: ShopCubit().favmodel.message,
            fontsize: 14,
            Backgroundcolor: Colors.amber,
          );
        }
        if(state is ChangeFavouritesShopError){
          DefaultToast(message:'Something Went Wrong! Please Try Again Later.' , fontsize: 16,Backgroundcolor: Colors.red);
        }
      },
      builder: (context,state){
         if(ShopCubit.get(context).favorites == null) return Center(child: CircularProgressIndicator());
         else if(ShopCubit.get(context).favorites.data.data.length == 0){
           return Center(
             child: Text('No Favourites Yet! Please Add Some.',
             textAlign: TextAlign.center,
             style: TextStyle(
               color: Colors.purpleAccent[400].withOpacity(0.6),
               fontSize: 18
             ),),
           );
         }
        else return ListView.separated(
             physics: BouncingScrollPhysics(),
             itemBuilder: (context,index) => FavScreenWidgetsBuilder(ShopCubit.get(context).favorites.data.data[index],context),
             separatorBuilder:(context,index) => Container(
               height: 1,
               width: 110,
               color: Colors.grey[400],
             ),
             itemCount: ShopCubit.get(context).favorites.data.data.length,
           );
      },
    );
  }

}
