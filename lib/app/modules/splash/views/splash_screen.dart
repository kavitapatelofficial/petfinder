import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petapp/app/component/buttons/defaultbutton.dart';
import 'package:petapp/app/constent/static_images.dart';
import 'package:petapp/app/modules/home/views/home_view.dart';
import 'package:petapp/app/modules/login/views/login_view.dart';
import 'package:petapp/app/modules/signup/views/signup_screen_two.dart';
import 'package:petapp/app/modules/signup/views/signup_six.dart';
import 'package:petapp/app/modules/signup/views/signup_view.dart';
import 'package:petapp/app/modules/signup/views/signup_with_number.dart';
import 'package:petapp/services/base_client.dart';

import '../../../component/buttons/oulined_button.dart';
import '../../../constent/colors.dart';
import '../../../constent/textthem.dart';

class SplashScreenTwo extends StatefulWidget {
  const SplashScreenTwo({Key? key}) : super(key: key);

  @override
  State<SplashScreenTwo> createState() => _SplashScreenTwoState();
}

class _SplashScreenTwoState extends State<SplashScreenTwo> {


   start() async {
    await GetStorage.init();
    print(
        "=========pet id==========${BaseClient.box2.read("pet_id")}=============");
    Timer(const Duration(seconds: 2), () {
      BaseClient.box2.read("logintoken") != null
          ? BaseClient.box2.read("pet_id") == null
              ? Get.offAll(SignupView())
              : BaseClient.box2.read("name") == null
                  ? Get.offAll(SignupViewTwo())
                  : BaseClient.box2.read("pet_name") == null
                      ? Get.offAll(SignupViewSix())
                      : Get.offAll(HomeView())
          : Get.offAll(const SplashScreenTwo());
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
          extendBodyBehindAppBar:true,
        backgroundColor: Color(0xfff544099),
        body: Container(
          height: size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(Constants.SPLASH1))
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RoundedButton(
                press: () {
                  Get.offAll(const SignUpWithNumber());
                },
                text: "Sign Up",
              ),
              const SizedBox(
                height: 24,
              ),
              OutlinedRoundedButton(
                press: () {
                  Get.offAll(const LoginView());
                  // Get.offAll(SignupViewSix());
                  // Get.to(SignupViewTwo());
                },
                text: "Login",
              ),
              const SizedBox(
                height: 43,
              )
            ],
          ),
          
        ),
      ),
    );
  }
}
