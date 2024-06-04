import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:tiktok/controllers/login_auth.dart';
import 'package:tiktok/views/screens/auth/signup_screen.dart';

import '../../../constants.dart';
import '../../widgets/custembutten.dart';
import '../../widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
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
              const Text(
                "TickTok Login",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: txtcolor),
              ),
              const SizedBox(
                height: 25,
              ),

              TextInputField(
                controller: _emailcontroller,
                icon: Icons.email_outlined,
                labelText: "email",
                obIs: false,
              ),
              const SizedBox(
                height: 25,
              ),

              TextInputField(
                controller: _passwordcontroller,
                icon: Icons.lock_open_sharp,
                labelText: "password",
                obIs: true,
              ),
              const SizedBox(
                height: 25,
              ),

              CustomButtonAuth(
                  title: "login",
                  onPressed: () {
                    loginAuth.singInWithGamilPasswored(
                        email: _emailcontroller.text.trim(),
                        password: _passwordcontroller.text.trim());
                  }),
              const SizedBox(
                height: 25,
              ),

              //login with google
              MaterialButton(
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(deflut_padding)),
                  color: Colors.red[700],
                  textColor: Colors.white,
                  onPressed: () {
                     LoginAuth.instance.signInWithGoogle();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Login With Google  "),
                      Image.asset(
                        "assets/icon/google_logo.png",
                        width: 20,
                      )
                    ],
                  )),

              const SizedBox(
                height: 5,
              ),
//regstier
              InkWell(
                onTap: () {
                  Get.to(const SingUpScreen());
                },
                child: const Center(
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: "Don't Have An Account ? ",
                    ),
                    TextSpan(
                        text: "Register",
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
