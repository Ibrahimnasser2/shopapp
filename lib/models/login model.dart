class login_model{
  bool? status;
  String? message;
  user_data? data;

  login_model.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
    data=json["data"]!=null?user_data.fromJson(json["data"]):null;


  }

}
class user_data{
int? id;
String? name;
String? email;
String? phone;
String? image;
String? token;

user_data({
  this.id,
  this.email,
  this.image,
  this.name,
  this.phone,
  this.token
});

user_data.fromJson(Map<String,dynamic>json){
  id=json["id"];
  email=json["email"];
  image=json["image"];
  name=json["name"];
  phone=json["phone"];
  token=json["token"];

}


}