class GetFavouritesModel{
  bool status;
  Data data;
  GetFavouritesModel.fromjson(Map<String , dynamic> json){
    status = json['status'];
    data = Data.fromjson(json['data']);
  }
}

class Data{
  int id;
  List<FavouritesProduct> FavData = [];

  Data.fromjson(Map<String,dynamic> json){
    json['data'].forEach((element){
      id = json['id'];
      FavData.add(FavouritesProduct.fromjson(element));
    });
  }
}


class FavouritesProduct{
  FavouritesProductData product;

  FavouritesProduct.fromjson(Map<String , dynamic> json){
    product = FavouritesProductData.fromjson(json['product']);
  }
}


class FavouritesProductData{
  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  String image;
  String name;

  FavouritesProductData.fromjson(Map<String , dynamic> json){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];

    }
}

