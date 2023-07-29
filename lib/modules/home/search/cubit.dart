
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review/modules/home/search/state.dart';

import '../../../models/search_model.dart';
import '../../../network/remote/dio_helper.dart';
import '../../../shared/constant/end_point.dart';

class search_cubit extends Cubit<search_states>{
  search_cubit() : super(search_intial_state());
  static search_cubit get(context)=> BlocProvider.of(context);
  searchModel? search_Model;


  void get_search(String given){

    emit(loading_search_data_state());

    dio_helper.post_data(
      data: {
        "text":given
      },
      token: token,
      url: search,).then((value){
      search_Model=searchModel.fromJson(value.data);

      print(search_Model!.data!.data![0].name);


      emit(sucess_get_search_data_state());
    }).catchError((error){
      emit(fail_get_search_data_state(error));
    });
  }



}