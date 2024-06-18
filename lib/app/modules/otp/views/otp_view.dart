import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petapp/app/common_api.dart';
import 'package:petapp/app/component/buttons/defaultbutton.dart';
import 'package:petapp/app/constent/api_urls.dart';
import 'package:petapp/app/model/otp_response_model.dart';

import 'package:petapp/app/modules/signup/views/signup_screen_two.dart';
import 'package:petapp/app/modules/signup/views/signup_six.dart';
import 'package:petapp/app/modules/signup/views/signup_view.dart';

import '../../../../services/base_client.dart';
import '../../../component/buttons/default_light_btn.dart';
import '../../../component/headings/my_headingtext.dart';
import '../../../constent/colors.dart';
import '../../../constent/static_images.dart';
import 'otp_field.dart';

class OtpView extends StatefulWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final TextEditingController otpController = TextEditingController();
  String otp = "";

  final _formKey = GlobalKey<FormState>();
  BaseClient baseClient = BaseClient();
  OtpResponseModel? otpResponseModel;
  bool isOtp = false;
  bool isLoading = true;

  start() async {
    await GetStorage.init();
    print(
        "=========pet id==========${BaseClient.box2.read("pet_id")}=============");
    Timer(const Duration(seconds: 2), () {
      BaseClient.box2.read("pet_id") == null
          ? Get.offAll(SignupView())
          : BaseClient.box2.read("pet_name") == null
              ? Get.offAll(SignupViewSix())
              : BaseClient.box2.read("name") == null
                  ? Get.offAll(SignupViewTwo())
                  : Get.offNamedUntil('/home', (route) => false);
    });
  }

  verifyOtp() async {
    var data = {
      "otp": double.parse(otpController.text),
    };
    final apiResponse = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(baseClient.post(
        false,
        ConstantsUrls.baseURL,
        "${ConstantsUrls.otpUrl}/${BaseClient.box2.read("user_id")}",
        data,
      )),
    );
    if (apiResponse != null) {
      if (apiResponse == 400) {
        otpController.text = "";
        Fluttertoast.showToast(
          msg: "You entered Incoorect Otp",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColor.neturalRed,
          textColor: Colors.white,
        );
      } else {
        var response = otpResponseModelFromJson(apiResponse);
        if (response.doc != null) {
          BaseClient.box2.write("user_id", response.doc!.id);
          BaseClient.box2.write("logintoken", response.doc!.token);
          BaseClient.box2.write("name", response.doc!.name);
        }
        Fluttertoast.showToast(
          msg: "${response.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        // Get.offAll(SignupView());
        
        start();
      }
    }
  }

  @override
  void initState() {
    CommonAPI.getOwner();
        CommonAPI.getallpet();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.accentWhite,
          body: ListView(
            children: [
              Column(
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
                  const MyHeadingTwoText(text: "Verify your number"),
                  const SizedBox(
                    height: 21,
                  ),
                  MyBodyText(
                      text:
                          "Enter the OTP code sent to your registered number +91 ${BaseClient.box2.read("user_enter_phone")}"),
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
                              padding:
                                  const EdgeInsets.only(bottom: 15, right: 10),
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
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 53),
                      child: Filled(
                        controller: otpController,
                        onChanged: (value) {
                          if (value!.length == 4) {
                            setState(() {
                              isOtp = true;
                            });
                          } else {
                            setState(() {
                              isOtp = false;
                            });
                          }
                        },
                        validate: (value) {
                          if (value!.isEmpty) {
                            return "Please enter otp";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 53),
                      child: isOtp
                          ? RoundedButton(
                              text: "Submit",
                              press: () {
                                otpvalid();
                                // Get.offAll(SignupView());
                              },
                            )
                          : LightRoundedButton(
                              text: "Submit",
                              press: () {
                                // otpvalid();
                                // Get.offAll(SignupView());
                              },
                            )),
                  const SizedBox(
                    height: 63,
                  ),
                ],
              ),
            ],
          )),
    );
  }

  void otpvalid() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      verifyOtp();
    } else {
      // Fluttertoast.showToast(
      //   msg: "Please enter OTP",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      //   timeInSecForIosWeb: 2,
      //   backgroundColor: AppColor.neturalRed,
      //   textColor: Colors.white,
      // );
      return;
    }
  }
}
