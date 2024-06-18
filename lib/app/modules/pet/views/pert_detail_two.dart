import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:petapp/app/component/buttons/defaultbutton.dart';
import 'package:petapp/app/component/headings/my_headingtext.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/modules/signup/views/statusbar.dart';

import '../../../component/textformfields/my_textform_field.dart';
import '../../../component/textformfields/textform_field_icon.dart';
import '../../../constent/textthem.dart';
import '../../home/views/home_view.dart';
import '../../signup/controllers/signup_controller.dart';

class PetDetailTwo extends GetView<SignupController> {
  const PetDetailTwo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.accentWhite,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                    status: '4',
                  ),
                  const SizedBox(
                    height: 37,
                  ),
                  const MyHeadingTwoText(text: "Pet Details"),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Upload your Pet’s Latest  Photo",
                        textAlign: TextAlign.center,
                        style: Texttheme.bodyText1.copyWith(fontSize: 12),
                      ),
                    ],
                  ),
                  Image.asset("assets/images/adhar.png",
                      height: 132, width: 132),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        child: Text(
                          "If younger than 10 months, we will remind you to update your dog’s photo every 30 days.",
                          textAlign: TextAlign.center,
                          style: Texttheme.bodyText1.copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 56,
                    width: screenSize.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/Home/Dog.png",
                          color: AppColor.accentLightGrey,
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Expanded(
                          child: MyTextFormField(
                            hintText: 'Name',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: MyTextFormField(
                          hintText: 'Breed',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MyTextFormField(
                          hintText: 'Gender',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 56,
                    width: screenSize.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/Home/Birthday.png",
                          color: AppColor.accentLightGrey,
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: TextFormFieldIcon(
                            hintText: 'Date of Birth',
                            // prefixIcon: Icons.email,
                            icon: Icon(Icons.calendar_month),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const MyBodyText(text: "Last Vaccination Details"),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 56,
                    width: screenSize.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/Home/injection.png",
                          color: AppColor.accentLightGrey,
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Expanded(
                          child: TextFormFieldIcon(
                            hintText: 'Anti-rabies',
                            // prefixIcon: Icons.email,
                            icon: Icon(Icons.calendar_month),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: const [
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: TextFormFieldIcon(
                          hintText: '7-1 or similar',
                          // prefixIcon: Icons.email,
                          icon: Icon(Icons.calendar_month),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 66,
                  ),
                  RoundedButton(
                    text: "Submit",
                    press: () {
                      Get.offAll( HomeView());
                    },
                  ),
                  const SizedBox(
                    height: 73,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
