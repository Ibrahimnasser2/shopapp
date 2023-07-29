

import 'package:shared_preferences/shared_preferences.dart';

class cash_helper{

  static SharedPreferences? shared_preferences;
  static init()async{
    shared_preferences= await SharedPreferences.getInstance();

  }




  static Future<bool> setbool({
   required  key,
    required value
})async{
    return await shared_preferences!.setBool(key, value);

  }

  static  dynamic  get_data ({required String key}){
    return  shared_preferences!.get(key);


  }




  static Future<bool> saved_values({
    required  key,
    required value
  })async{
    if(value is String){return await shared_preferences!.setString(key, value);}
    if(value is int){return await shared_preferences!.setInt(key, value);}
    if(value is bool){return await shared_preferences!.setBool(key, value);}
    else return await shared_preferences!.setDouble(key, value);


  }

  static Future<bool> removedata({required String key})async{
    return await shared_preferences!.remove(key);

  }


  }