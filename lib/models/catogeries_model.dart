class categories_model{
  late final bool status;

  categories_data_modle? data;

  categories_model.fromJson(Map<String,dynamic>json){
    status=json["status"];
    data= categories_data_modle.fromJson(json["data"]);


  }


}
class categories_data_modle{
  late final int current_page;
  List<data_modle> data=[];
  categories_data_modle.fromJson(Map<String,dynamic>json){
    json["data"].forEach((element){
      data.add(data_modle.fromJson(element));
    },


    );
    this.current_page=json["current_page"]??=0;
  }}

class data_modle{

  late final int id;
  late final String image;
  late final String name;

  data_modle.fromJson(Map<String,dynamic>json){
    this.id=json["id"]??=0;
    this.image=json["image"]??="";
    this.name=json["name"]??="";


  }}

