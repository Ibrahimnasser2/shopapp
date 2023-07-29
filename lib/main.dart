import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:review/layout/shop_layout/cubit/home_cubit.dart';
import 'package:review/layout/shop_layout/shop_layout.dart';
import 'package:review/shared/bloc_observer.dart';
import 'package:review/shared/constant/end_point.dart';


import 'modules/login_page.dart';
import 'modules/onboarding.dart';
import 'network/local/cach_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  dio_helper.init();
  await cash_helper.init();
  dynamic onboarding=cash_helper.get_data(key: "onboarding");
   token=cash_helper.get_data(key: "token");


  Widget firstpage;
  if(onboarding!=null){

    if(token!=null){
      firstpage=shop_layout();
    }
    else{
      firstpage=login();
    }
  }
  else{
    firstpage=onboarding1();
  }
  runApp(MyApp(startpage:firstpage ,));

}

class MyApp extends StatelessWidget {
  Widget startpage;
  MyApp( {required this.startpage});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>home_cubit()..get_home_data()..get_categories_data()..get_favorites_data(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme:AppBarTheme(color: Colors.white,
          elevation:0.0,



          ) ,

          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.blue) ,
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.deepOrange),button:TextStyle(color: Colors.deepOrange),
          ) ,





          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: startpage,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

