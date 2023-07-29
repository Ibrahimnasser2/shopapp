class home_model{
  late final bool status;

  late final  home_data_modle data;

  home_model.fromJson(Map<String,dynamic>json){
    this.status=json["status"];
    this.data=  home_data_modle.fromJson(json["data"]) ;

  }


}
class home_data_modle{
  List<banner_modle> banners=[];
  List<product_modle> products=[];
  home_data_modle.fromJson(Map<String,dynamic>json){
    json["banners"].forEach((element){
      banners.add(banner_modle.fromJson(element));
    });
    json["products"].forEach((element){
      products.add(product_modle.fromJson(element));
    });

  }}

class banner_modle{

  late final int id;
  late final String image;

  banner_modle.fromJson(Map<String,dynamic>json){
    this.id=json["id"];
    this.image=json["image"];


  }}
class product_modle{

  late final int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
  late final String image;
  late final  String name;
  late final bool in_favorites;
  late final bool in_cart;


  product_modle.fromJson(Map<String,dynamic>json){

    this.name=json["name"];
    this.id=json["id"];
    this.image=json["image"];
    this.price=json["price"];
    this.old_price=json["old_price"];
    this.discount=json["discount"];
    this.in_favorites=json["in_favorites"];
    this.in_cart=json["in_cart"];


  }}
