import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review/shared/constant/end_point.dart';

import '../../layout/login/cubit/login_cubit.dart';
import '../../layout/login/cubit/state.dart';
import '../../layout/shop_layout/shop_layout.dart';
import '../../models/login model.dart';
import '../../network/local/cach_helper.dart';
import '../../shared/components/tools.dart';
import '../login_page.dart';

class settings extends StatelessWidget {


  var emailcon =TextEditingController();

  var phonecon =TextEditingController();

  var namecon =TextEditingController();



  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context)=>login_cubit(),
      child: BlocConsumer<login_cubit,login_states>(
          listener: (context, state){
            if(state is login_success_state){

                emailcon.text=state.loginmodel!.data!.email!;
                phonecon.text=state.loginmodel!.data!.phone!;
                namecon.text=state.loginmodel!.data!.name!;



            }

            if(state is update_data_success_state){
              if(state.updatemodel!.status==true){
                toast(message: state.updatemodel!.message, state: toast_states.sucess);
              }
              else{
                toast(message: state.updatemodel!.message, state: toast_states.fail);
              }


            }




          },
          builder: (context, state){
            login_cubit cubit= login_cubit.get(context);



            return Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Form(
                    key: formkey,
                    child: Column(crossAxisAlignment:CrossAxisAlignment.start ,
                      children: [
                        if(state is update_loading_state)
                          LinearProgressIndicator(),
                        SizedBox(height: 10,),
                        default_Text_form(
                          controller: namecon,
                          labelText:"Name" ,
                          prefixIcon:Icons.person ,
                          textInputType: TextInputType.name ,),
                        SizedBox(height: 10,),

                        default_Text_form(
                          controller: emailcon,
                          labelText:"E-mail address" ,
                          prefixIcon:Icons.email ,
                          textInputType: TextInputType.emailAddress ,),
                        SizedBox(height: 10,),
                        default_Text_form(
                          controller: phonecon,
                          labelText:"Phone" ,
                          prefixIcon:Icons.phone ,
                          textInputType: TextInputType.phone ,),

                        SizedBox(height: 10,),

                        Center(
                          child:default_button(function:(){
                            if(formkey.currentState!.validate()){
                              cubit.update_user_data(
                                  email: emailcon.text,
                                  name: namecon.text,
                                  phone: phonecon.text);
                            }




                          } ,text: "Update",) ,


                        ),

                        SizedBox(height: 10,),
                        Center(
                          child:default_button(function:(){
                            cash_helper.removedata(key: "token");
                            nav_and_finish(context, login());


                          } ,text: "logout",) ,


                        ),

                        camper()





                      ],),
                  ),
                ),
              ));
          }

      ),
    );
  }
}