import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review/shared/components/tools.dart';

import '../../layout/shop_layout/cubit/home_cubit.dart';
import '../../layout/shop_layout/cubit/home_states.dart';
import '../../models/catogeries_model.dart';

class catogries extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<home_cubit,home_states>(
      listener: (context, state){},
        builder: (context, state){
          home_cubit cubit=home_cubit.get(context);
        return Scaffold(body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
            shrinkWrap: true,
          scrollDirection: Axis.vertical,
    itemBuilder: (context,index)=>categories_buliderr(cubit.categoriesmodel!.data!.data[index]),
    separatorBuilder: (context,index)=>my_seperatorr(),
    itemCount: cubit.categoriesmodel!.data!.data.length,

    ),
        ));
    });
    }
Widget categories_buliderr(data_modle data)=>Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Image(
      image: NetworkImage("${data.image}"),
      fit: BoxFit.fill,
      height: 110,
      width: 110,
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text("${data.name}",
        style: TextStyle(color: Colors.black,
            fontSize: 20,



        ),),
    ),
    Spacer(),
    Icon(Icons.arrow_forward_ios_sharp)

  ],
);
}