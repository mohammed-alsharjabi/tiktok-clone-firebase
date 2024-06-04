
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String _message;
  String  _sender;
  String  _receiver;
  String  _time;


  Message(this._message, this._sender, this._receiver,this._time);

// Message({required this.message,required this.sender,required this.receiver});

  Map<String,dynamic> toJson() {
    return {
      "message":_message,
      "sender":_sender,
      "receiver":_receiver,
    };

  }



  static  Message formJson(DocumentSnapshot snapshot) {
    var snapshots = snapshot.data() as Map<String, dynamic>;

    return Message( snapshots['message'],  snapshots['sender'],  snapshots['receiver'],snapshots['time']);
  }

  String get sender => _sender;

  String get receiver => _receiver;
  String get message => _message;

}