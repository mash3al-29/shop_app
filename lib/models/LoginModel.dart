class LoginModel{
  bool status;
  String message;
  UserData data;

  LoginModel.fromjson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromjson(json['data']) : null;
  }
}

class UserData{
  int id;
  String name;
  String email;
  String phone;
  String token;

  UserData.fromjson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
}

}