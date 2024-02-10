import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/CategoriesModel.dart';
import 'package:shop_app/models/Products_Model.dart';
import 'package:shop_app/shared/components/components.dart';

class Products_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context,state){return ShopCubit.get(context).productsModel != null && ShopCubit.get(context).categoriesModel != null ? ProductsListBuilder(ShopCubit.get(context).productsModel,context) : Center(child: CircularProgressIndicator());},
        listener: (context,state){
          if(state is ChangeFavouritesStatusFalseShop){
            DefaultToast(
              message: ShopCubit().favmodel.message,
              fontsize: 14,
              Backgroundcolor: Colors.amber,
            );
          }
          if(state is ChangeFavouritesShopError){
            DefaultToast(
              message: 'Something Went Wrong! Please Try Again Later.',
              fontsize: 14,
              Backgroundcolor: Colors.red[600],
            );
          }

        }
    );

  }

  Widget ProductsListBuilder(ProductsModel model,context,){
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CarouselSlider(
            items: model.data.banners.map(
                    (e) => Image(image:
                NetworkImage('${e.image}'),
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
            ).toList(),
            options: CarouselOptions(
                viewportFraction: 1.0,
                height: 225.0,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal
            ),
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 250,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.purple[400],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 120,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index) => CategoryOnScreen(ShopCubit.get(context).categoriesModel,index),
                separatorBuilder: (context,index) => SizedBox(width: 7,),
                itemCount:ShopCubit.get(context).categoriesModel.data.categories.length,
            ),
          ),
          SizedBox(height: 18,),
          Container(
            width: double.infinity,
            height: 0.5,
            color: Colors.grey[300],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.purple[400],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('New Products',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),),
              ),
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children:
               List.generate(model.data.products.length, (index) => ProductOnScreen(model.data.products[index],context)),
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1/1.69,
            ),
          ),
        ],
      ),
    );
  }

    Widget ProductOnScreen(ProductModel model,context){
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                ),
                if(model.discount != 0 ) Container(
                  child: Text('DISCOUNT',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    backgroundColor: Colors.red,
                  ),),
                ),
              ],
              alignment: AlignmentDirectional.bottomStart,
            ),
            Text(
              model.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10,),
            Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
              '${model.price.round()}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.purple[400],
                height: 0.8,
              fontSize: 16,
              )),
              SizedBox(width: 10,),
              if(model.discount != 0)  Text(
                  '${model.old_price.round()}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey[500],
                    height: 0.8,
                    fontSize: 16,
                  )),
              Spacer(),
              IconButton(
                  icon: CircleAvatar(
                    radius: 45,
                      backgroundColor: ShopCubit.get(context).Favourites[model.id] ? Colors.purple[400] : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14,
                        color: Colors.white,
                      ),
                  ),
                  onPressed: (){
                    ShopCubit.get(context).ChangeFavourites(model.id);
                  },
              ),
            ],
          ),

          ],
        ),
      ),
    );
  }

  Widget CategoryOnScreen(CategoriesModel model,int index){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.centerLeft,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Image(
              image: NetworkImage(model.data.categories[index].image),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 5,),
            Container(
              width: 100,
              color: Colors.purple[400].withOpacity(0.7),
              child: Text('${model.data.categories[index].name}',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                ),),
            ),
          ],
        ),
      ),
    );
  }
}
