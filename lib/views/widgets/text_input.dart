
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class TextInputField extends StatelessWidget
{
  final TextEditingController controller;
  final String labelText;
  final bool obIs;
  final IconData icon;


  const TextInputField({super.key, required this.controller, required this.labelText, required this.obIs, required this.icon});



  @override
  Widget build(BuildContext context) {
   return TextField(
     controller:controller ,
     decoration: InputDecoration(
       labelText: labelText,
       prefixIcon: Icon(icon),
       labelStyle: const TextStyle(fontSize: 18),
       enabledBorder: OutlineInputBorder(
         borderRadius: BorderRadius.circular(deflut_padding),
         borderSide:const BorderSide(
           color: borderColor,
         )

       ),
         focusedBorder:  OutlineInputBorder(
     borderRadius: BorderRadius.circular(20),
       borderSide:const BorderSide(
         color: Colors.blue,
       ),


   ),


     ),
     obscureText: obIs,
   );
  }


}