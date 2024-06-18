import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petapp/app/component/headings/my_headingtext.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/modules/signup/views/signup_six.dart';

import '../../../component/buttons/default_light_btn.dart';
import '../../../constent/static_images.dart';
import '../../otp/views/otp_field.dart';
import '../controllers/signup_controller.dart';

class SignupViewFive extends GetView<SignupController> {
  SignupViewFive({Key? key}) : super(key: key);
  final TextEditingController otpController=TextEditingController();
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
              height: 92,
            ),
            const MyHeadingText(text: "OTP"),
            const SizedBox(
              height: 56,
            ),
            const MyHeadingTwoText(text: "OTP Verification"),
            const SizedBox(
              height: 21,
            ),
            const MyBodyText(
                text:
                    "Enter the OTP code sent to your registered number +91 8823-32xx-xx"),
            const SizedBox(
              height: 37,
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
                          Constants.RIGHT_CIRCLE,
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
              child: Filled(
                      controller: otpController,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter otp";
                        } else {
                          return null;
                        }
                      },
                    ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 53),
                child: LightRoundedButton(
                  text: "Login",
                  press: () {
                    Get.offAll(const SignupViewSix());
                  },
                )),
            const SizedBox(
              height: 63,
            ),
          ],
        ),
      )),
    );
  }
}
