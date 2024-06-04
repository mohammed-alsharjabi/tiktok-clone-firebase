import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/constants.dart';
import 'package:tiktok/models/message.dart';

import '../../controllers/message_controller.dart';

import 'package:get/get.dart';

class MessageScreen extends StatefulWidget {
  String receiverEmail;
  String receiverName;
  String receiverProfile;

  MessageScreen(
      {super.key,
      required this.receiverEmail,
      required this.receiverName,
      required this.receiverProfile});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String uid = firebaseAuth.currentUser!.uid;
  final MessageController chatUsercontroller = Get.put(MessageController());

  String email = firebaseAuth.currentUser!.email!;
  final TextEditingController _messaageController = TextEditingController();

  final iconColor = Colors.black;
  final bgColor = const Color(0xffedecf2);
  final bool isMe = true;

  // final Stream<QuerySnapshot> _messageStreem = firestore.collection('message').snapshots();
  final List<Message>listMessage=[];
getMessage()async{
  await for(var itemDoc in firestore.collection("message").snapshots())
    {
      for(var message in itemDoc.docs )
      {
        Message mis=Message(message.get("message"),message.get("sender") ,message.get("receiver"), message.get("message"));
        listMessage.add(mis );


      }

    }
}

@override
  void initState() {
    super.initState();
    getMessage();

  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,

        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: bgColor,
          leading: Container(
            alignment: Alignment.topRight,

            margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(
                      image: NetworkImage(widget.receiverProfile),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  widget.receiverName,
                  style: TextStyle(
                    color: iconColor,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                )
              ],
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.keyboard_arrow_right,
                  size: 40,
                  color: iconColor,
                )),
          ],
        ),

        body: Expanded(
          child: Container(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(
                horizontal: 7, vertical: 5),
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 5),
            child: Column(

              crossAxisAlignment:isMe? CrossAxisAlignment.start:CrossAxisAlignment.end,

              children: [

              Expanded(child:  StreamBuilder(stream: messageController.getMessageStream(),
                  builder:  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
                  {
                    if (snapshot.hasError) {
                      return Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.deepOrangeAccent,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            'Something went wrong',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ));
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          margin:const EdgeInsets.symmetric(vertical: 40),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Text(
                            '....Loading',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ));
                    }


                    return
                      Column(

                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;

                          return   Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 7, vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              width: 100,
                              decoration:firebaseAuth.currentUser!.email==data['receiver']?
                              const BoxDecoration(
                                  color: Colors.cyanAccent,
                                  borderRadius:  BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  boxShadow:  [
                                    BoxShadow(
                                        color: Colors.white12,
                                        spreadRadius: 10,
                                        blurStyle: BlurStyle.solid)
                                  ])
                                  :const BoxDecoration(
                          color: Colors.lightGreen,
                          borderRadius:  BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20)),
                          boxShadow:  [
                          BoxShadow(
                          color: Colors.white12,
                          spreadRadius: 10,
                          blurStyle: BlurStyle.solid)
                          ]),
                              child:  Text(
                                data['message'],
                                style: const TextStyle(color: Colors.black,fontSize: 18,),
                              ));
                        }).toList(),
                      );



                  }), ),



                //message and button send
                SingleChildScrollView(
                  child: Container(
                    height: 50,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 3),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: CircleAvatar(
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt,
                                    color: Colors.white),
                                onPressed: () {},
                              ),
                            )),
                        Expanded(
                          flex: 4,
                          child: TextField(
                            controller: _messaageController,

                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                hintText: "اكتب هنا",
                                hintStyle: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                filled: true,
                                fillColor: bgColor,
                                border: InputBorder.none),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        MaterialButton(
                          onPressed: () {
                            if (_messaageController.text != null) {
                              Message message = Message(
                                _messaageController.text,
                                  email,
                                widget.receiverEmail,
                              FieldValue.serverTimestamp().toString());
                              messageController.sendMessage(message, uid);
                              _messaageController.clear();
                            }
                          },
                          child: Icon(
                            Icons.send,
                            color: iconColor,
                            size: 33,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
