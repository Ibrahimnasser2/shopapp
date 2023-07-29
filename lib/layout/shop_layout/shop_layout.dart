
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review/layout/shop_layout/cubit/home_cubit.dart';
import 'package:review/layout/shop_layout/cubit/home_states.dart';
import 'package:review/modules/home/search.dart';
import 'package:review/shared/components/tools.dart';

class shop_layout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<home_cubit,home_states>(
        listener: (context, state){},
        builder: (context, state){
          home_cubit cubit=home_cubit.get(context);
       return Scaffold(
          appBar: AppBar(title: Text(
            "salla",style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w500),),
            actions: [
              IconButton(onPressed: (){
                navigate_to(context,search());
              }, icon: Icon(Icons.search,
              color: Colors.black,))
            ],
          
          ),
          body: cubit.home_pages[cubit.current_page],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomitem,
            onTap: (index){
              cubit.change_bottom_index(value: index);


            },

            currentIndex: cubit.current_page,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
          ) ,
        );
      },



    );
  }
}
