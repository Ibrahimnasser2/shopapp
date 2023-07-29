import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review/modules/home/search/cubit.dart';
import 'package:review/modules/home/search/state.dart';

import '../../layout/shop_layout/cubit/home_cubit.dart';
import '../../models/search_model.dart';
import '../../shared/components/tools.dart';

class search extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    var serch=TextEditingController();
    var formkey = GlobalKey<FormState>();
    return BlocProvider(
      create: (BuildContext context)=>search_cubit(),
      child: BlocConsumer<search_cubit,search_states>(
        listener: (context,state){},
        builder: (context,state){
          search_cubit cubit=search_cubit.get(context);
          return Scaffold(
            appBar: AppBar(

              iconTheme:IconThemeData(color: Colors.black ) ,
            ) ,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    controller: serch ,
                    keyboardType: TextInputType.text,
                    onChanged: (String value){
                      cubit.get_search(value);
                    },
                    onFieldSubmitted: (String value){
                      cubit.get_search(value);
                    },

                    validator: (value){
                      if(!(value!.isEmpty)){
                        return null;
                      }
                      return("not valid");
                    } ,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),

                      labelText: "search" ,
                      prefixIcon: Icon( Icons.search),

                    ) ,

                  ),
                ),
                if(state is loading_search_data_state)
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: LinearProgressIndicator(),
                  ),


                if(state is sucess_get_search_data_state)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: double.infinity,
                        child: ListView.separated(
                          scrollDirection:Axis.vertical ,
                            shrinkWrap: true,
                            itemBuilder:(context,index)=>search_buliderr(cubit.search_Model!.data!.data![index],context),
                            separatorBuilder: (context,index)=>my_seperatorr(),
                            itemCount: cubit.search_Model!.data!.data!.length),
                      ),
                    ),
                  ),


              ],
            ),

          );
        },

      ),
    );


  }
  Widget search_buliderr(Product model,context)=>Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage("${model.image}"),
                fit: BoxFit.fill,
                height: 100,
                width: 100,
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

                        

                        Spacer(),

                        Padding(
                          padding: const EdgeInsets.all(3),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: model.in_favorites!?Colors.blue:Colors.grey,


                            child: IconButton(onPressed: (){
                              toast(message: "can't change favorite product here", state: toast_states.warning);
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
    ),
  );

}