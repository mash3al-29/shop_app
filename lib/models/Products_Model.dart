class ProductsModel{
  bool status;
  Data data;

  ProductsModel.fromjson(Map<String,dynamic> json){
    status = json['status'];
    data = Data.fromjson(json['data']);
  }
  }




class Data{
      List<ProductModel> products = [];
      List<BannerModel> banners = [];

  Data.fromjson(Map<String,dynamic> json){
    json['banners'].forEach((element){
      banners.add(BannerModel.fromJson(element));
    });

    json['products'].forEach((element){
      products.add(ProductModel.fromJson(element));
    });


  }
}

class ProductModel{
  int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  List<dynamic> images;
  String image;
  String name;
  bool in_favorites;
  bool in_cart;

  ProductModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    price = json['price'];
    old_price = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    images = json['images'];
    in_favorites = json['in_favorites'];
    in_cart = json['in_cart'];


  }
}

class BannerModel{
    int id;
    String image;
  BannerModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    image = json['image'];
  }
}

