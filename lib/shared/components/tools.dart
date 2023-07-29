

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void nav_and_finish(context, newRoute)=>Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context)=>newRoute), (route) => false);

void navigate_to(context,widget){
  Navigator.push(
      context, MaterialPageRoute(builder: (context)=>widget)

  );
}




Widget default_button({

  double width= double.infinity,
  Color back_ground= Colors.blue,
  required Function function ,
  required String text,


}) =>Container(
  width:width,
  color: back_ground,
  child: MaterialButton(
    child: Text(text,style: TextStyle(
        fontSize: 20,color: Colors.white),),
    onPressed: (){
      function();
    } ,


  ),
);







Widget default_Text_form({

  required TextEditingController controller,
  required  TextInputType textInputType,
  required String labelText,
  required IconData prefixIcon,
  IconButton? suffixIcon,
  bool ispassword =false,



}) =>TextFormField(
  controller: controller ,
  keyboardType: textInputType,

  onFieldSubmitted: (String value){
    print(value);
  },
  validator: (value){
    if(!(value!.isEmpty)){
      return null;
    }
    return("not valid");
  } ,
  decoration: InputDecoration(
    border: OutlineInputBorder(),

    labelText: labelText ,
    prefixIcon: Icon( prefixIcon),
    suffixIcon:   suffixIcon,

  ) ,
  obscureText: ispassword,


);


void toast({
  required message,
  required state
}){

Fluttertoast.showToast(msg: message,
    backgroundColor:choose_color(state),
  fontSize: 15,
  gravity: ToastGravity.BOTTOM,
  textColor: Colors.white,
  timeInSecForIosWeb: 10,

);


}

enum toast_states {sucess,fail,warning}



Color choose_color(toast_states states){
  Color color;
  switch(states){
    case toast_states.sucess:
      color=Colors.green;
      break;
    case toast_states.fail:
      color=Colors.red;
      break;
    case toast_states.warning:
      color=Colors.amber;
      break;

  }
  return color;
}


Widget my_seperatorr()=>Container(
  width: double.infinity,
  height: 2,
  color: Colors.grey[200],
);





Widget camper()=>Row(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("Developed by:",style: TextStyle(
        color: Colors.teal,
        fontSize: 20,
        fontWeight: FontWeight.w900

    )),
    SizedBox(width: 5,),
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(

          children: [
            Text("Camper 01153421455"),
            Icon(Icons.contact_page_outlined,color: Colors.green,)
          ],
        ),

      ],
    ),
  ],
);





