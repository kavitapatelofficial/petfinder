import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:petapp/app/common_api.dart';
import 'package:petapp/app/component/buttons/defaultbutton.dart';
import 'package:petapp/app/component/headings/my_headingtext.dart';
import 'package:petapp/app/component/textformfields/fixed_label_textformfiled.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/static_images.dart';
import 'package:petapp/app/model/messge_model.dart';

import 'package:petapp/app/model/signup_model.dart';

import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:petapp/app/modules/login/views/login_view.dart';
import 'package:petapp/app/modules/otp/views/otp2.dart';

import '../../../../services/base_client.dart';
import '../../../constent/api_urls.dart';

class SignUpWithNumber extends StatefulWidget {
  const SignUpWithNumber({Key? key}) : super(key: key);

  @override
  State<SignUpWithNumber> createState() => _LoginViewState();
}

class _LoginViewState extends State<SignUpWithNumber> {
  final TextEditingController phoneController = TextEditingController();
  int phone = 0;

  final _formKey = GlobalKey<FormState>();
  BaseClient baseClient = BaseClient();
  SignupModel? signupModel;
  bool isLoading = true;

  signup() async {
     print("======sign up screen========player id=======${BaseClient.box2.read("osUserID")}==================");
    var box = GetStorage();
    
    await OneSignal.shared.setAppId("fd6441ce-bef2-4467-981c-6b0fac4f09ae");
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;

    print(
        "=========OneSignal.shared player id======$osUserID======${box.read("osUserID")}=========");
    var data = {
      "user": {
        "phoneNumber": phone.toInt(),
         "deviceId": "${BaseClient.box2.read("osUserID")==null?"":BaseClient.box2.read("osUserID")}"
      }
    };


    print("================data======$data==========");

    final apiResponse = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(baseClient.post(
        false,
        ConstantsUrls.baseURL,
        ConstantsUrls.signUpUrl,
        data,
      )),
    );

    if (apiResponse != null) {
      var response = messageModelFromJson(apiResponse);
      if (response.success == false) {
        phoneController.text = "";
        Fluttertoast.showToast(
          msg: "${response.message} you can login with phone number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColor.neturalRed,
          textColor: Colors.white,
        );
        // Get.offAll(const LoginView());
      } else {
        BaseClient.box2.write("user_enter_phone", phone.toInt());
        var data = signupModelFromJson(apiResponse);
        BaseClient.box2.write("user_id", data.doc!.id);
        BaseClient.box2.write("userLogin", data.userLogin);
        BaseClient.box2.write("phone", data.doc!.phoneNumber);
        Fluttertoast.showToast(
          msg: "${response.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Get.offAll(const OtpViewTwo());
      }
    }
  }

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
                // const SizedBox(
                //   height: 92,
                // ),
                const MyHeadingText(text: "Sign Up"),
                const SizedBox(
                  height: 56,
                ),
                const MyHeadingTwoText(text: "Sign Up with Mobile Number"),
                const SizedBox(
                  height: 21,
                ),
                const MyBodyText(
                    text:
                        "Enter your mobile number so that we can verify you with OTP"),
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
                    Positioned(
                        left: 80,
                        top: 0,
                        child: Image.asset(
                          Constants.DOG2,
                          height: 153,
                          width: 159,
                        )),
                    Positioned(
                        right: 30,
                        bottom: 30,
                        child: Image.asset(
                          Constants.CIRCLE,
                          height: 42,
                          width: 42,
                          color: HexColor("#F1F1F1"),
                        )),
                    Positioned(
                        left: 10,
                        top: 60,
                        child: Image.asset(
                          Constants.CIRCLE,
                          height: 29,
                          width: 29,
                          color: HexColor("#F1F1F1"),
                        )),
                    Positioned(
                        left: 30,
                        top: 30,
                        child: Image.asset(
                          Constants.CIRCLE,
                          height: 22,
                          width: 22,
                          color: HexColor("#F1F1F1"),
                        ))
                  ],
                ),
                const SizedBox(
                  height: 39,
                ),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 53),
                    child: FixedLabelTextFormField(
                      maxlength: 10,
                      prefixText: "+91 ",
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      hintText: '8823-32xx-xx',
                      labelText: 'Mobile Number',
                      onChanged: (value) {
                        setState(() {
                          phone = int.parse(value);
                        });
                      },
                      icon: phone == 0
                          ? const SizedBox()
                          : InkWell(
                              onTap: () {
                                phoneController.text = "";
                              },
                              child: Image.asset(
                                "assets/images/icon.png",
                                height: 6,
                                width: 6,
                              ),
                            ),
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter phone number";
                        } else if (value.length != 10) {
                          return "Please enter valid phone number";
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
                    child: RoundedButton(
                      text: "Send OTP",
                      press: () {
                        userSignUp();
                        // Get.offAll(OtpView());
                      },
                    )),

                     Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Already have an account"),
                        TextButton(onPressed: (){
                          Get.offAll(LoginView());

                        }, child: Text("Login here"))
                      ],
                    ),
                const SizedBox(
                  height: 64,
                ),
              ],
            ),
          )),
    );
  }

  void userSignUp() {
    if (phoneController.text.length == 10) {
      // print(passController.text);

      // loginController.loginWithDetail(
      //     useridController.text, passController.text);
      signup();
    } else {
      // Fluttertoast.showToast(
      //   msg: "Please enter phone number",
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
