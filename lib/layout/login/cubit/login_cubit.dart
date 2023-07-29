
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review/layout/login/cubit/state.dart';
import 'package:review/models/login%20model.dart';
import 'package:review/network/remote/dio_helper.dart';
import 'package:review/shared/constant/end_point.dart';




class login_cubit extends Cubit<login_states>{
  login_cubit() : super( login_intial_state() );
  static login_cubit get(context)=> BlocProvider.of(context);
  login_model? loginmodel;
  login_model? updatemodel;

  IconData? suff =Icons.visibility;
  bool ispass=true;

void user_login({required String email,required String pass}){
  
  emit(login_loading_state());

  dio_helper.post_data(url: login1, data: {"email":email,"password":pass}).then((value) {
    loginmodel=login_model.fromJson(value.data);
    print(value);

    emit(login_success_state(loginmodel));
  }).catchError((onError){
    print(onError.toString());
    emit(login_fail_state(onError.toString()));
  });
}

void password_cahnge(){
  ispass=!ispass;
  suff= ispass?  Icons.visibility:  Icons.visibility_off;
  emit(chang_pass_state());
}





  void update_user_data({required String email,required String name,required  phone}){
  emit(update_loading_state());

    dio_helper.put_data(url: updateprofile, data: {"email":email,"phone":phone,"name":name},token: token).then((value) {
      updatemodel=login_model.fromJson(value.data);
      print(value);

      emit(update_data_success_state(updatemodel));
    }).catchError((onError){
      print(onError.toString());
      emit(update_data_fail_state(onError.toString()));
    });
  }







}