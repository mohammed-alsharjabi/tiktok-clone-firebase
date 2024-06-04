

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class CustumButton extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return MaterialButton(onPressed: (){},
  shape: OutlineInputBorder(borderSide:const BorderSide(color:borderColor,style: BorderStyle.solid),borderRadius: BorderRadius.circular(20)),
    padding:const EdgeInsets.all(5),
    animationDuration: const Duration(milliseconds: 100),
    focusColor: Colors.redAccent,

    child: Text("",style: TextStyle(color: txtcolor2,fontWeight: FontWeight.bold,fontSize: 20)),
  );
  }

}



class CustomButtonAuth extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  const CustomButtonAuth({super.key,  this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      minWidth: 400,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(deflut_padding)),
      color: Colors.red[700],
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(title,style:const TextStyle(fontSize: 18),),
    );
  }
}
