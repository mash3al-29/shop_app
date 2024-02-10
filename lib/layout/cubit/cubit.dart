
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/CategoriesModel.dart';
import 'package:shop_app/models/ChangeFavourites.dart';
import 'package:shop_app/models/GetFavourites.dart';
import 'package:shop_app/models/GetOmElFavorites.dart';
import 'package:shop_app/models/LoginModel.dart';
import 'package:shop_app/models/Products_Model.dart';
import 'package:shop_app/modules/categories.dart';
import 'package:shop_app/modules/favourites.dart';
import 'package:shop_app/modules/products.dart';
import 'package:shop_app/modules/settings.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/EndPoints.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/Dio_Helper.dart';

class ShopCubit extends Cubit<ShopStates>{
  ShopCubit() : super(InitialShopState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  ChangeFavouritesModel favmodel;
  ProductsModel productsModel;
  CategoriesModel categoriesModel;
  GetFavouritesMiaw favorites;
  LoginModel UserDataProfile;
  String token = CacheHelper.GetData(key: 'token');
  Map<int,bool> Favourites = {};

  List<Widget> pages = [
    Products_Screen(),
    Categories_Screen(),
    Favourites_Screen(),
    Settings_Screen(),
  ];



  void ChangeBottomNav(int index){
    currentIndex = index;
    emit(ChangeNavBarShopApp());
  }

  Future<dynamic> GetProducts() async{
    return await DioHelper.GetData(url: Home,token: CacheHelper.GetData(key: 'token')).then((value) {
      emit(GetProductsShopLoading());
       productsModel = ProductsModel.fromjson(value.data);
      print(productsModel.status);
      print(token);
      productsModel.data.products.forEach((element) {
        Favourites.addAll({element.id : element.in_favorites});
      });
      print(Favourites.toString());
      emit(GetProductsShopSucsess());
    }).catchError((dynamic error){
      print(error);
      emit(GetProductsShopError(error.toString()));
    });
  }

  Future<dynamic> GetCategories() async{
    emit(GetCategoriesShopLoading());
    return await DioHelper.GetData(url: CATEGORIES, lang: 'en',).then((value) {
      categoriesModel = CategoriesModel.fromjson(value.data);
      emit(GetCategoriesShopSucsess());
    }).catchError((error){
      print(error.toString());
      emit(GetCategoriesShopError(error));
    });
  }

  Future<dynamic> ChangeFavourites(int productID) async {
    Favourites[productID] = !Favourites[productID];
    emit(ChangeFavouritesShopLoading());
    return await DioHelper.PostData(
        url: FAVOURITES,
        data: {
          'product_id' : productID
        },
      token: token,
    ).then((value) {
      favmodel = ChangeFavouritesModel.fromjson(value.data);
      if(favmodel.status == false){
        Favourites[productID] = !Favourites[productID];
        emit(ChangeFavouritesStatusFalseShop());
      }else{
        GetFavorites();
        emit(ChangeFavouritesShopSucsess());
      }
    }).catchError((dynamic error){
      Favourites[productID] = !Favourites[productID];
      emit(ChangeFavouritesShopError(error));
      print(error.toString());
    });
  }

  Future<dynamic> GetFavorites() async{
    emit(GetFavouritesShopLoading());
    return await DioHelper.GetData(url: FAVOURITES, lang: 'en',token: token).then((value) {
      favorites = GetFavouritesMiaw.fromJson(value.data);
      emit(GetFavouritesShopSucsess());
    }).catchError((error){
      print(error.toString());
      emit(GetFavouritesShopError(error));
    });
  }


  Future<dynamic> GetUserData() async{
    emit(GetProfileLoading());
    return await DioHelper.GetData(url: PROFILE, lang: 'en',token: token).then((value) {
      UserDataProfile = LoginModel.fromjson(value.data);
      print (value.data);
      emit(GetProfileSucses());
    }).catchError((error){
      print(error.toString());
      emit(GetProfileError());
    });
  }




}
