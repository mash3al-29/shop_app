class CategoriesModel{
  bool status;
  CategoriesData data;
  CategoriesModel.fromjson(Map<String,dynamic> json){
    status = json['status'];
    data = CategoriesData.fromjson(json['data']);
}
}

class CategoriesData {
  List<Categories> categories = [];
  CategoriesData.fromjson(Map<String,dynamic> json){
    json['data'].forEach((element) {
      categories.add(Categories.fromjson(element));
    });
  }
}

class Categories{
  int id;
  String name;
  String image;

  Categories.fromjson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}