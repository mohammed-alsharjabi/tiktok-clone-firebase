

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok/constants.dart';

import '../models/user.dart';

class ChatController extends GetxController
{
  final Rx<List<User>> _chatUser = Rx<List<User>>([]);

  List<User> get chatUser => _chatUser.value;





  List<QueryDocumentSnapshot> data = [];

  getData() async {


    QuerySnapshot querySnapshot = await firestore
        .collection("users")
        .get();
    data.addAll(querySnapshot.docs);

  return data;


  }

}