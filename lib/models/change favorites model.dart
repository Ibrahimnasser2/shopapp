import 'dart:convert';

class change_fav{
  late final bool status;
  late final String? message;
  change_fav.fromJson(Map<String,dynamic>json){
    status=json["status"];
    message=json["message"];
  }


}