
import 'package:dio/dio.dart';

class dio_helper{
  static Dio? dio;

  static init(){
  dio=Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
        headers: {
          "Content-Type":"application/json"
        }

      )
  );

  }

  static Future<Response> get_data({
  required String url,
     Map<String,dynamic>? quiries,
    String lang="ar",
    String? token,

})async{

    dio!.options.headers={
      "lang":lang,
      "Authorization":token
    };
    return await dio!.get(url,queryParameters: quiries);


}


  static Future<Response> post_data({
    required String url,
     String lang="en",
    String? token,

    required Map<String,dynamic> data,


  })async{
     dio!.options.headers={
       "lang":lang,
       "Authorization":token
     };

    return await dio!.post(url,data: data);


  }



  static Future<Response> put_data({
    required String url,
    String lang="en",
    String? token,

    required Map<String,dynamic> data,


  })async{
    dio!.options.headers={
      "lang":lang,
      "Authorization":token
    };

    return await dio!.put(url,data: data);


  }




}