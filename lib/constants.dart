

// COLORS
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tiktok/controllers/login_auth.dart';
import 'package:tiktok/views/screens/add_vidio_screen.dart';
import 'package:tiktok/views/screens/auth/login_screen.dart';
import 'package:tiktok/views/screens/auth/signup_screen.dart';
import 'package:tiktok/views/screens/chat_screen.dart';
import 'package:tiktok/views/screens/message_screen.dart';
import 'package:tiktok/views/screens/profile_screen.dart';
import 'package:tiktok/views/screens/search_screen.dart';
import 'package:tiktok/views/screens/video_screen.dart';

import 'controllers/auth_controller.dart';
import 'controllers/message_controller.dart';

const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
const txtcolor = Colors.redAccent;
const txtcolor2 = Colors.white;


const deflut_padding=10.0;
const deflut_margin=10.0;



// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// CONTROLLER
var authController = AuthController.instance;
var loginAuth = LoginAuth.instance;
var messageController=MessageController.instance;


