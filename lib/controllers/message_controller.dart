
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/models/message.dart';

class MessageController extends GetxController
{
  static MessageController instance = Get.find();
  final Rx<List<Message>> _messageList = Rx<List<Message>>([]);

  List<Message> get messageList => _messageList.value;

  sendMessage(Message message,String uid)async{
  try{
// await firestore.collection("messages").doc(uid).collection("message").add(message.toJson());

    await firestore.collection("message").add(message.toJson());
  }
  catch(e){Get.snackbar("Error", "essage");}
  }



  @override
  void onInit() {
    super.onInit();
    _messageList.bindStream(
        firestore.collection('message').snapshots().map((QuerySnapshot query) {
          List<Message> retVal = [];
          for (var element in query.docs) {
            retVal.add(
              Message.formJson(element),
            );
          }
          return retVal;
        }));
  }


  getMessage(AsyncSnapshot<QuerySnapshot> snapshot ){
List<Message>messageList=[];

     final messages=snapshot.data!.docs;
  for(var message in messages){
    Message messageInfo=Message( message.get("messages"), message.get("message"), message.get("receiver"),message.get("messages"));

    messageList.add(messageInfo);
  }
  return  messageList;
  }


  getMessageStream() {
    final Stream<QuerySnapshot> messageStream =firestore.collection('message').snapshots();
    // final Stream<QuerySnapshot>messages=firestore.collection("messages").doc("uid").collection("message").snapshots();
     return messageStream;
  }
}