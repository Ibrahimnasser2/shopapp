import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_layout/cubit/home_cubit.dart';
import '../../layout/shop_layout/cubit/home_states.dart';
import '../../models/catogeries_model.dart';
import '../../models/favorites model.dart';
import '../../models/home_data_model.dart';
import '../../shared/components/tools.dart';

class favorites extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    home_cubit cubit=home_cubit.get(context);
    return  BlocConsumer<home_cubit,home_states>(
        listener: (context, state){},
        builder: (context, state){


          return Scaffold(body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ConditionalBuilder(
              builder: (context)=>ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context,index)=>fav_buliderr(cubit.Favorites_Model!.data!.data![index].product!,context),
                separatorBuilder: (context,index)=>my_seperatorr(),
                itemCount: cubit.Favorites_Model!.data!.data!.length,

              ),
              condition: cubit.Favorites_Model!=null,
              fallback:(context)=>Center(child: CircularProgressIndicator()) ,

            ),
          ));
        });
  }
  Widget fav_buliderr(Products model,context)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage("${model.image}"),
              fit: BoxFit.fill,
              height: 150,
              width: 150,
            ),
            if(model.discount!=0)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Text("Discount",
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white
                  ),),
              )
          ],
        ),
        Expanded(
          child: Container(
            height: 150,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.start ,
                children: [

                  Text("${model.name}",maxLines: 2,
                    style: TextStyle(
                        height: 1,
                        overflow:TextOverflow.ellipsis
                    ),),
                  Spacer(),

                  Row(
                    children: [
                      Text("${model.price.round()}",
                        style: TextStyle(color: Colors.blue,
                          fontSize: 18

                        ),),
                      SizedBox(width: 10,),

                      if(model.discount!=0)
                        Text("${model.oldPrice.round()}",
                          style: TextStyle(color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12

                          ),),
                      Spacer(),

                      Padding(
                        padding: const EdgeInsets.all(3),
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: home_cubit.get(context).favories_map[model.id]!?Colors.blue:Colors.grey,


                          child: IconButton(onPressed: (){
                            home_cubit.get(context).change_favorites_s(model.id!);
                          },padding:EdgeInsets.zero ,
                              icon: Icon(

                                Icons.favorite_border,
                                color: Colors.white,
                                size: 18,

                              )),
                        ),
                      )

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),


      ],
    ),
  );
}