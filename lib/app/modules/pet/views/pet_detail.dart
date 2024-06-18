import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:petapp/app/component/buttons/defaultbutton.dart';
import 'package:petapp/app/component/buttons/upload_chip_button.dart';
import 'package:petapp/app/component/headings/my_headingtext.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/modules/pet/views/pert_detail_two.dart';

import '../../../component/textformfields/fixed_label_textformfiled.dart';
import '../../signup/controllers/signup_controller.dart';

class PetDetailOne extends GetView<SignupController> {
  const PetDetailOne({Key? key}) : super(key: key);
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
                const MyHeadingText(text: "Pet Details"),
                const SizedBox(
                  height: 24,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: SizedBox(
                      width: 249,
                      child: MyHeadingTwoText(
                          text: "Scan the Chip and enter the RFID number")),
                ),
                const SizedBox(
                  height: 54,
                ),
                Image.asset(
                  "assets/images/pet6.png",
                  height: 204,
                  width: 213,
                  // color: AppColor.accentLightGrey,
                ),
                const SizedBox(
                  height: 30,
                ),
                const UploadChipButton(
                  text: "Upload Chip Certificate",
                  showicon: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 53),
                  child: FixedLabelTextFormField(
                      hintText: '123-32xxx',
                      labelText: 'RFID Number',
                      icon: Image.asset("assets/images/icon.png")),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 53),
                    child: RoundedButton(
                      text: "Proceed",
                      press: () {
                        Get.to(const PetDetailTwo());
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
