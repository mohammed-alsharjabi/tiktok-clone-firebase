

import 'package:flutter/material.dart';

class MessageAccountItem extends  StatelessWidget
{
  Color colorCard;
  String avatarPath;
  String accountName;
  VoidCallback onPerss;

  MessageAccountItem({super.key,required this.colorCard,required this.avatarPath,required this.accountName,required this.onPerss,});
  
  @override
  Widget build(BuildContext context) {
    
 return Container(
   width: double.infinity,
   margin:const  EdgeInsets.symmetric(horizontal: 10,vertical: 3),
   padding:const  EdgeInsets.symmetric(horizontal: 5,vertical: 1),
   color: colorCard,
   child: ElevatedButton(
     style: ButtonStyle(
       alignment: Alignment.center,
       animationDuration:const  Duration(milliseconds: 100),
       backgroundColor: MaterialStateProperty.all(Colors.transparent),
       padding: MaterialStateProperty.all(const EdgeInsets.all(7))
     ),
     onPressed: onPerss,
     child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         const Spacer(),
         // name
        Center(
               child: Text(accountName,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 20),),
             ),
         const SizedBox(width:20 ,),

         Container(
           width: 50,
           height: 50,
           padding: const EdgeInsets.all(1),
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(25),
           ),
           child: ClipRRect(
             borderRadius: BorderRadius.circular(25),
             child: Image(
               image: NetworkImage(avatarPath),
               fit: BoxFit.cover,
             ),
           ),
         ),


       ],
     ),
   ),
   
 );
  }
  
  
}