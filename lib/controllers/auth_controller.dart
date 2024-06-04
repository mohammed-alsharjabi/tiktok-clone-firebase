
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok/views/screens/auth/login_screen.dart';
import 'package:tiktok/views/screens/home_screen.dart';

import '../constants.dart';
import 'package:tiktok/models/user.dart' as model;

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  void onPicImage(BuildContext context, {Function? onDone}) async {
    // bool showResult = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      PlatformFile file = result!.files.single;
      String fileName = result.files.first.name;
      File aculeFile = File(file.path!);

      FirebaseStorage.instance
          .ref(fileName)
          .putFile(aculeFile)
          .snapshotEvents
          .listen((event) {
        int totleByte = event.totalBytes;
        int byteTransfren = event.bytesTransferred;

        if (totleByte == byteTransfren) {
          onDone!();
        }
        notifyChildrens();
      }, onDone: () => Get.snackbar("title", "message"));
    }
  }


  late Rx<File?> _picimage;
late Rx<User?> _user;

  File? get getpicimage => _picimage.value;
User get user => _user.value!;

@override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() =>const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void selectImage() async {
    final picimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picimage != null) {
      Get.snackbar("profile  ", "you have successfully selected picture");
    _picimage = Rx<File?>(File(picimage!.path));

    }
    else {
      Get.snackbar("profile  ", "you have note successfully selected picture");
    }


  }

//   upload image file
  Future<String> _uploadImageFile(File image) async {
    Reference reference =
        firebaseStorage.ref("avatar").child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
// registrtion user

  void registerUser(
      {required username,
      required name,
      required email,
      required password,
      required File? image}) async {
    try {
      if (username.isNotEmpty &&
          name.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        UserCredential credential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);
        update();

        String downloadUrl = await _uploadImageFile(image);
      
        model.User users = model.User(
            name: name,
            username: username,
            email: email,
            profie: downloadUrl,
            uid: credential.user!.uid,
            password: password);

        await firestore
            .collection("users")
            .doc(credential.user!.uid)
            .set(users.toJson());

  
      } else {
        Get.snackbar("Error  you  have no account ", "empty data ");
      }
    } catch (e) {
      Get.snackbar("Error  you  have no account ", e.toString());
    }
  }

  
 void signOut() async {
    await firebaseAuth.signOut();
  }
}
