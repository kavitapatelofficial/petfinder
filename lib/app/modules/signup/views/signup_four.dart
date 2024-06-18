import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petapp/app/component/buttons/defaultbutton.dart';

import 'package:petapp/app/component/headings/my_headingtext.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/static_images.dart';
import 'package:petapp/app/modules/signup/views/signup_five.dart';

import 'package:petapp/app/modules/signup/views/statusbar.dart';

import '../../../component/textformfields/fixed_label_textformfiled.dart';

class SignupViewFour extends StatefulWidget {
  const SignupViewFour({Key? key}) : super(key: key);

  @override
  State<SignupViewFour> createState() => _SignupViewFourState();
}

class _SignupViewFourState extends State<SignupViewFour> {
  final TextEditingController phoneController = TextEditingController();

  String phone = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
          backgroundColor: AppColor.accentWhite,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const MyHeadingText(text: "Sign Up"),
                const SizedBox(
                  height: 24,
                ),
                const StatusBar(
                  status: '3',
                ),
                const SizedBox(
                  height: 37,
                ),
                const MyHeadingTwoText(text: "Aadhaar Verification"),
                const SizedBox(
                  height: 21,
                ),
                const MyBodyText(
                    text:
                        "Enter your Aadhar number so that we can verify your identity"),
                const SizedBox(
                  height: 54,
                ),
                Stack(
                  children: [
                    Container(
                      // color: AppColor.neturalBrown,
                      padding: const EdgeInsets.only(right: 20),
                      height: 217,
                      width: 250,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, top: 20),
                      child: Image.asset(
                        Constants.CIRCLE,
                        height: 159,
                        width: 159,
                        color: HexColor("#F1F1F1"),
                      ),
                    ),


                     Positioned.fill(
                    left: 0,
                    top: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15,right: 10),
                        child: Image.asset(
                          Constants.THUMB,
                          height: 51,
                          width: 51,
                        ),
                      ),
                    )),
                   
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 53),
                  child: FixedLabelTextFormField(
                      controller: phoneController,
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                      hintText: '7432-xxxx-xxxx',
                      labelText: 'Aadhaar Number',
                      icon: phone.isEmpty
                          ? const SizedBox()
                          : Image.asset("assets/images/icon.png")),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 53),
                    child: RoundedButton(
                      text: "Send OTP",
                      press: () {
                        Get.offAll(SignupViewFive());
                      },
                    )),
                const SizedBox(
                  height: 73,
                ),
              ],
            ),
          )),
    );
  }
}
