

import 'package:get/get.dart';

import '../constants.dart';
import '../views/screens/add_vidio_screen.dart';
import '../views/screens/chat_screen.dart';
import '../views/screens/profile_screen.dart';
import '../views/screens/search_screen.dart';
import '../views/screens/video_screen.dart';

class HomeController extends  GetxController
{

  int pageIdx = 0;


  List pages = [
    VideoScreen(),
    SearchScreen(),
    const AddVideoScreen(),
    const  ChatScreen(),
    ProfileScreen(uid: authController.user.uid),
  ];
}