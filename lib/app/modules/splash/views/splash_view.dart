import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:petapp/app/common_api.dart';
import 'package:petapp/app/modules/splash/views/splash_screen.dart';
import 'package:petapp/services/base_client.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  start() async {
    await GetStorage.init();
    print(
        "=========pet id==========${BaseClient.box2.read("pet_id")}=============");
    Timer(const Duration(seconds: 3), () {
      BaseClient.box2.read("is_full_detail_completed") == true
          ? Get.offNamedUntil('/home', (route) => false)
          : Get.offAll(const SplashScreenTwo());
    });
  }

  @override
  void initState() {
    CommonAPI.getOwner();
    CommonAPI.getallpet();
    start();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/Splash_Screen.gif"))),
        );
  }
}
