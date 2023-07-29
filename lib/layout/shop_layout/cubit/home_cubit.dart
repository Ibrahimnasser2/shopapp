

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review/models/catogeries_model.dart';
import 'package:review/models/home_data_model.dart';
import 'package:review/modules/home/catogeries.dart';
import 'package:review/modules/home/favourit.dart';
import 'package:review/modules/home/product.dart';
import 'package:review/modules/home/settings.dart';
import 'package:review/network/remote/dio_helper.dart';
import 'package:review/shared/constant/end_point.dart';

import '../../../models/change favorites model.dart';
import '../../../models/favorites model.dart';
import 'home_states.dart';

class home_cubit extends Cubit<home_states>{
  home_cubit() : super( home_intial_state() );
  static home_cubit get(context)=> BlocProvider.of(context);

  int current_page=0;
  home_model? homemodel;
  change_fav? change_fav_model;
  categories_model? categoriesmodel;
  FavoritesModel?Favorites_Model;
  Color favor_colors=Colors.blue;
  Map<int,bool>favories_map={};
  bool is_favor=false;
  List<Widget> home_pages=[product(), catogries(), favorites(), settings()];
  List<BottomNavigationBarItem> bottomitem=[
    BottomNavigationBarItem(icon: Icon(Icons.home),label: "home"),
    BottomNavigationBarItem(icon: Icon(Icons.apps),label: "categories"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "favourites"),
    BottomNavigationBarItem(icon: Icon(Icons.settings),label: "settings"),

  ];

  void change_bottom_index({required int value}){
    current_page=value;
    emit(changehome_state());
}


  void change_favorites_s(int id){
    favories_map[id]=!favories_map[id]!;
    emit(succ_changefavor_state());
    dio_helper.post_data(data: {
      "product_id":id
    },url:get_favorites,
      token: token


    ).then((value) {

      change_fav_model=change_fav.fromJson(value.data);
      print(value.data);
      if(!change_fav_model!.status){
        favories_map[id]=!favories_map[id]!;

      }
      else{
        get_favorites_data();

      }

      emit(succ_changefavor_state2(change_fav_model));




    }).catchError((error){
      print(error);
      emit(fail_changefavor_state());
    });
  }



  void get_home_data(){
    emit(product_loading_data_state());
    dio_helper.get_data(url: home1,lang: "en",token: token ).then((value) {
      homemodel=home_model.fromJson(value.data);
      homemodel!.data.products.forEach((e){
        favories_map.addAll({e.id:e.in_favorites});
      });

      print(homemodel!.data.products[0].image);
      emit(product_success_data_state(homemodel));


    }).catchError((error){
      emit(product_fail_data_state(error.toString()));
    });
  }

  void get_categories_data(){
    emit(categorie_loading_data_state());
    dio_helper.get_data(url: get_catogeries,lang: "en" ).then((value) {
      categoriesmodel=categories_model.fromJson(value.data);
      emit(categorie_success_data_state(categoriesmodel));

    }).catchError((error){
      emit(categorie_fail_state(error.toString()));
    });
  }


  void get_favorites_data(){
    emit(fav_loading_data_state());
    dio_helper.get_data(url: get_favorites,lang: "en",token: token ).then((value) {
      Favorites_Model=FavoritesModel.fromJson(value.data);


      emit(fav_success_data_state(Favorites_Model));

    }).catchError((error){
      emit(fav_fail_data_state(error.toString()));
    });
  }




























}