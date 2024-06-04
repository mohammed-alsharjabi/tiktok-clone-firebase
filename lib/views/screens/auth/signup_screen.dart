import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/models/user.dart';
import 'package:tiktok/views/screens/auth/login_screen.dart';

import '../../../constants.dart';
import '../../widgets/custembutten.dart';
import '../../widgets/text_input.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SingUpScreen();
  }
}

class _SingUpScreen extends State<SingUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  final TextEditingController _namecontroller = TextEditingController();
  static const double destance = 20;

  getImage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    File file = File(image!.path);

    try {
      var refStroge = firebaseStorage.ref("4.jpg");
      await refStroge.putFile(file!);
    } catch (e) {
      print("sssssssssssssssssssssssssssssssssssssssssssss" + e.toString());
    }
    setState(() {});
    //done
  }

  void selectFileX() async {
    final storageRef = FirebaseStorage.instance.ref("ma");
// Create a reference to "mountains.jpg"
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    final mountainsRef = storageRef.child("dsfdsf");

    File file = File(result!.files.single.path!);

    try {
      await mountainsRef.putFile(file);
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  late Rx<File?> xfile;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(
              vertical: deflut_padding, horizontal: deflut_padding),
          margin: const EdgeInsets.symmetric(
              vertical: deflut_padding, horizontal: deflut_padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
//title
              const Text(
                "TickTok SingUp",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: txtcolor),
              ),
              const SizedBox(
                height: destance * 2,
              ),

              Stack(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/icon/google_logo.png"),
                  ),
                  Positioned(
                      bottom: -10,
                      left: 80,
                      child: IconButton(
                          onPressed: () => authController.selectImage(),
                          icon: const Icon(Icons.add_a_photo)))
                ],
              ),
              const SizedBox(
                height: destance,
              ),

              TextInputField(
                controller: _namecontroller,
                icon: Icons.email_outlined,
                labelText: "name",
                obIs: false,
              ),
              const SizedBox(
                height: destance,
              ),

              TextInputField(
                controller: _usernamecontroller,
                icon: Icons.email_outlined,
                labelText: "username",
                obIs: false,
              ),
              const SizedBox(
                height: destance,
              ),

              TextInputField(
                controller: _emailcontroller,
                icon: Icons.lock_open_sharp,
                labelText: "email",
                obIs: false,
              ),
              const SizedBox(
                height: destance,
              ),

              TextInputField(
                controller: _passwordcontroller,
                icon: Icons.lock_open_sharp,
                labelText: " password",
                obIs: true,
              ),
              const SizedBox(
                height: destance,
              ),
              CustomButtonAuth(
                  title: "SingUp",
                  onPressed: () async {
                    authController.registerUser(
                        username: _usernamecontroller.text,
                        name: _namecontroller.text,
                        email: _emailcontroller.text,
                        password: _passwordcontroller.text,
                        image: authController.getpicimage);

                    //  final picimage= await ImagePicker().pickImage(source: ImageSource.gallery);

                    //        xfile = Rx<File?>(File(picimage!.path));
                    //   Reference reference = firebaseStorage
                    //       .ref("avatar")
                    //       .child(firebaseAuth.currentUser!.uid);

                    //   UploadTask uploadTask = reference.putFile(xfile.value!);
                    //   TaskSnapshot snap = await uploadTask;
                    //   String downloadUrl = await snap.ref.getDownloadURL();
                  }),

              const SizedBox(
                height: destance,
              ),

              const SizedBox(
                height: 5,
              ),
//regstier
              InkWell(
                onTap: () {
                  Get.to(()=>const LoginScreen());
                },
                child: const Center(
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "You have account  ",
                    ),
                    TextSpan(
                        text: "login",
                        style: TextStyle(
                            color: Colors.orange, fontWeight: FontWeight.bold)),
                  ])),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
