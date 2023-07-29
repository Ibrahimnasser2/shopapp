
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:review/network/local/cach_helper.dart';
import 'package:review/shared/components/tools.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login_page.dart';
class boarding{
  late AssetImage image;
  late String title;
  late String body;
  boarding({required  this.image, required this.title,required this.body
  });

}
class onboarding1 extends StatelessWidget {
  List<boarding> boardingdata=[
    boarding(title: 'title1',body:"body" ,image: AssetImage("images/Picture1.png"), ),
    boarding(title: 'title2',body:"body" ,image: AssetImage("images/Picture2.png"), ),
    boarding(title: 'title3',body:"body" ,image:  AssetImage("images/Picture3.jpg"), ),

  ]  ;



 var boardcontroller =PageController();
 var lastpage= false;
  @override
  Widget build(BuildContext context) {


    void submit(){
      cash_helper.saved_values(key: "onboarding", value: true);


      nav_and_finish(context,login());
    }

    return  Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextButton(onPressed: ()=>submit( ),
                child: Text(
                  "skip",style: TextStyle(color: Colors.blue,fontSize: 16),)),
          )

        ],


      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start ,
        children: [
          Expanded(
            child: PageView.builder(
              controller: boardcontroller,
              itemBuilder:(context,index)=>pageviewcontent(boardingdata[index]) ,
              itemCount: boardingdata.length,
              onPageChanged: (index){
                if(index==(boardingdata.length-1)){
                  lastpage=true;
                }
                else{
                  lastpage=false;
                }
              },

            ),
          ),
          SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Row(
              children: [
                SmoothPageIndicator(
                    controller: boardcontroller,
                    count: 3,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 5,
                    activeDotColor: Colors.blue
                  ) ,
                ),
                Spacer(),
                FloatingActionButton(onPressed: (){
                  if(lastpage){
                    submit();
                  }
                  else{boardcontroller.nextPage(
                      duration:Duration(milliseconds: 500) , curve: Curves.linearToEaseOut );}

                },
                  child: Icon(Icons.arrow_forward_ios),
                ),

              ],),
          ),


        ],
      ),


    );
  }

  Widget pageviewcontent(boarding model) =>Padding(
  padding: const EdgeInsets.all(30),
  child: Column(
  crossAxisAlignment: CrossAxisAlignment.start ,
  children: [
  Expanded(
    child: Image(


    image: model.image
    ),
  ),
  SizedBox(height: 30,),
  Text("${model.title}",
  style:TextStyle(color: Colors.black,
  fontSize: 25,
  fontWeight: FontWeight.bold
  ) ,),
  SizedBox(height: 30,),
  Text("${model.body}",
  style:TextStyle(color: Colors.black,
  fontSize: 20,

  ) ,),
  ],
  ),
  );

}
