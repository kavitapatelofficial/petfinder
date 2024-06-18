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
import 'package:petapp/app/model/login_response.dart';
import 'package:petapp/app/model/messge_model.dart';

import 'package:petapp/app/model/signup_model.dart';

import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:petapp/app/modules/otp/views/otp_view.dart';
import 'package:petapp/app/modules/signup/views/signup_with_number.dart';

import '../../../../services/base_client.dart';
import '../../../constent/api_urls.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController phoneController = TextEditingController();
  int phone = 0;

  final _formKey = GlobalKey<FormState>();
  BaseClient baseClient = BaseClient();
  SignupModel? signupModel;
  bool isLoading = true;

  login() async {
    print(
        "======login screen========player id=======${BaseClient.box2.read("osUserID")}==================");
    var box = GetStorage();

    await OneSignal.shared.setAppId("fd6441ce-bef2-4467-981c-6b0fac4f09ae");
    final status = await OneSignal.shared.getDeviceState();
    final String? osUserID = status?.userId;
    box.write("osUserID", osUserID);

    print(
        "=========OneSignal.shared player id======$osUserID======${box.read("osUserID")}=========");
    var data = {
      "user": {
        "phoneNumber": phone.toInt(),
        "deviceId":
            "${BaseClient.box2.read("osUserID") == null ? "" : BaseClient.box2.read("osUserID")}"
      }
    };

    print("================data======$data==========");
    final apiResponse = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(baseClient.post(
        false,
        ConstantsUrls.baseURL,
        ConstantsUrls.loginUrls,
        data,
      )),
    );

    if (apiResponse != null) {
      var response = messageModelFromJson(apiResponse);
      if (response.success == false) {
        phoneController.text = "";
        Fluttertoast.showToast(
          msg: "${response.message} you can login with your phone number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColor.neturalRed,
          textColor: Colors.white,
        );
        // Get.offAll(const SignUpWithNumber());
      } else {
        BaseClient.box2.write("user_enter_phone", phone.toInt());
        var data = loginResponseModelFromJson(apiResponse);
        BaseClient.box2.write("user_id", data.doc!.id);
        BaseClient.box2.write("userLogin", data.userLogin);
        BaseClient.box2.write("phone", data.doc!.phoneNumber);

        Fluttertoast.showToast(
          msg: "Otp Sent successfully on your registered phone number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Get.offAll(const OtpView());
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
                const MyHeadingText(text: "Login"),
                const SizedBox(
                  height: 56,
                ),
                const MyHeadingTwoText(text: "Login with Mobile Number"),
                const SizedBox(
                  height: 21,
                ),
                const MyBodyText(
                    text:
                        "Enter your registered mobile number so that we can verify you with OTP"),
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
                        left: 20,
                        bottom: 100,
                        child: Image.asset(
                          "assets/images/dog22.png",
                          height: 53,
                          width: 76,
                        )),
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
                        left: 20,
                        top: 30,
                        child: Image.asset(
                          Constants.CIRCLE,
                          height: 29,
                          width: 29,
                          color: HexColor("#F1F1F1"),
                        )),
                    Positioned(
                        left: 50,
                        top: 10,
                        child: Image.asset(
                          Constants.CIRCLE,
                          height: 22,
                          width: 22,
                          color: HexColor("#F1F1F1"),
                        )),
                    Positioned(
                        right: 70,
                        bottom: 10,
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
                      autofill: <String>[AutofillHints.telephoneNumber],
                      prefixText: "",
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      hintText: ' 8823-32xx-xx',
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
                                setState(() {
                                  phoneController.text = "";
                                });
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
                        userLogin();
                        // Get.offAll(OtpView());
                      },
                    )),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Don't have an account"),
                    TextButton(
                        onPressed: () {
                          Get.offAll(SignUpWithNumber());
                        },
                        child: Text("Signup here"))
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

  void userLogin() {
    if (_formKey.currentState!.validate()) {
      login();
    } else {
      return;
    }
  }
}
