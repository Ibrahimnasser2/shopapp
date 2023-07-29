import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:review/layout/shop_layout/cubit/home_cubit.dart';
import 'package:review/layout/shop_layout/cubit/home_states.dart';
import 'package:review/models/home_data_model.dart';

import '../../models/catogeries_model.dart';
import '../../shared/components/tools.dart';

class product extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<home_cubit,home_states>(
        listener: (context, state){
          if(state is succ_changefavor_state2){
            if(!state.change_favmodel!.status){
              toast(message: state.change_favmodel!.message,state: toast_states.fail);
            }
          }

        },
       builder: (context, state){
          home_cubit cubit=home_cubit.get(context);
      return Scaffold(
          body: ConditionalBuilder(
            builder:(context)=>homebulider(cubit.homemodel!,cubit.categoriesmodel!,context) ,
            condition: cubit.homemodel!=null&&cubit.categoriesmodel!=null,
            fallback:(context)=> Center(child: CircularProgressIndicator(color: Colors.blue,)) ,
          )

      );
    }

    );


  }
  Widget homebulider(home_model model, categories_model catmodel,context)=>SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(items: model.data.banners.map((e)=>Image(
            image: NetworkImage("${e.image}"),
            fit: BoxFit.cover,
          )).toList(),
              options: CarouselOptions(
                height: 250,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3) ,
                autoPlayAnimationDuration: Duration(seconds: 1),
                scrollDirection: Axis.horizontal,
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 1,



              )),
          SizedBox(height: 30,),
          Text("Categories",
            style: TextStyle(color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w500


            ),),
          SizedBox(height: 20,),
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index)=>catogeries_builder(context,catmodel.data!.data[index]),
                  separatorBuilder: (context,index)=>SizedBox(width: 15,),
                  itemCount: catmodel.data!.data.length),
            ),
          ),

          SizedBox(height: 30,),
          Text("New products",
            style: TextStyle(color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w500


            ),),

          GridView.count(crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 1/1.75,
            children: List.generate(model.data.products.length, (index) => gridbulider(model.data.products[index],context)),

            mainAxisSpacing: 1,
            crossAxisSpacing: 1,

          )

        ],
      ),
    ),
  );

  Widget gridbulider(product_modle model,context)=>  Padding(
    padding: const EdgeInsets.all(5.0),
    child: Column(
      crossAxisAlignment:CrossAxisAlignment.start ,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage("${model.image}"),
              fit: BoxFit.fill,
              height: 200,
              width: 200,
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            children: [
              Text("${model.name}",maxLines: 2,
                style: TextStyle(
                height: 1,
                overflow:TextOverflow.ellipsis
              ),),
              Row(
                children: [
                  Text("${model.price.round()}",
                    style: TextStyle(color: Colors.blue,

                    ),),
                  SizedBox(width: 30,),
                  if(model.discount!=0)
                    Text("${model.old_price.round()}",
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
                        home_cubit.get(context).change_favorites_s(model.id);
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





      ],

    ),
  );

  Widget catogeries_builder(context, data_modle data,){
    home_cubit cubit=home_cubit.get(context);
    return Container(
      width: 100,
      child: Stack(
        alignment:AlignmentDirectional.bottomCenter ,
        children: [
          Image(
            image: NetworkImage("${data.image}"),
            fit: BoxFit.fill,
            height: 100,
            width: 100,
          ),
          Container(
            height: 25,
            width: double.infinity,
            color: Colors.black.withOpacity(.6),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Center(
                child: Text("${data.name}",maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      overflow:TextOverflow.ellipsis,
                      fontSize: 18
                  ),),
              ),
            ),
          )

        ],
      ),
    );
  }

}
