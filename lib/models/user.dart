import 'package:cloud_firestore/cloud_firestore.dart';

class User {
 final String name;
 final String username;
 final String email;
 final String profie;
 final  String password;
 final  String uid;

  User(
      {required this.name,
      required this.username,
      required this.email,
        required this.profie,
        required this.uid,
      required this.password});


  Map<String,dynamic> toJson() {
    return {
      "name": name,
      "username": username,
      "email": email,
      "password": password,
      "profile": profie,
      "uid": uid,
    };
  }

  static User formJson(DocumentSnapshot snapshot)
  {
    var snapshots=snapshot.data() as Map<String,dynamic>;
    return User(name: snapshots['name'], username:  snapshots['username'], email:  snapshots['email'], profie:  snapshots['profie'], uid:  snapshots['uid'], password:  snapshots['password']);
  }
}
