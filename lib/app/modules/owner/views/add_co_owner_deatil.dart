import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

import 'package:get/get.dart';
import 'package:petapp/app/component/buttons/defaultbutton.dart';
import 'package:petapp/app/component/headings/my_headingtext.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/modules/home/views/home_view.dart';
import 'package:petapp/app/modules/home/views/home_view2.dart';

import '../../../../services/base_client.dart';
import '../../../component/textformfields/my_textform_field.dart';
import '../../../constent/api_urls.dart';
import '../../../model/messge_model.dart';

class AddCoOwnerDetails extends StatefulWidget {
  const AddCoOwnerDetails({Key? key}) : super(key: key);

  @override
  State<AddCoOwnerDetails> createState() => _AddCoOwnerDetailsState();
}

class _AddCoOwnerDetailsState extends State<AddCoOwnerDetails> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  int phone = 0;

  final _formKey = GlobalKey<FormState>();
  BaseClient baseClient = BaseClient();
  // SignupModel? signupModel;
  bool isLoading = true;

  addCoWner() async {
    var data = {
      "owner": {
        "name": nameController.text,
        "phone": int.parse(phoneController.text).toInt(),
        "email": emailController.text
      }
    };

    final apiResponse = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(baseClient.post(
        true,
        ConstantsUrls.baseURL,
        "${ConstantsUrls.addCoowner}${BaseClient.box2.read("user_id")}",
        data,
      )),
    );

    if (apiResponse != null) {
      var response = messageModelFromJson(apiResponse);
      if (response.success == true) {
        phoneController.text = "";
        Fluttertoast.showToast(
          msg: "${response.message} ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 5,
          backgroundColor: AppColor.neturalGreen,
          textColor: Colors.white,
        );
        Get.offAll(HomeViewTwo(
          currentIndex: 2,
        ));
      } else {
        var response = messageModelFromJson(apiResponse);
        // BaseClient.box2.write("user_id", data.doc!.id);
        Fluttertoast.showToast(
          msg: "${response.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        // Get.offAll(OtpViewTwo());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: AppColor.primaryColor, //OR Colors.red or whatever you want
          ),
          elevation: 0,
          backgroundColor: AppColor.accentWhite,
        ),
        backgroundColor: AppColor.accentWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const MyHeadingText(text: "Add Co-owner Details"),
                  const SizedBox(
                    height: 72,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColor.accentLightGrey,
                        size: 33,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: MyTextFormField(
                          hintText: 'Name',
                          controller: nameController,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Name required";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call,
                        color: AppColor.accentLightGrey,
                        size: 33,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: MyTextFormField(
                          maxLength: 10,
                          hintText: 'Phone',
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "Phone required";
                            } else if (value.length != 10) {
                              return "Enter valid phone number";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        color: AppColor.accentLightGrey,
                        size: 33,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: MyTextFormField(
                          hintText: 'Email',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validate: (value) {
                            final bool isValid =
                                EmailValidator.validate(value!);
                            if (isValid == false) {
                              return "Email valid email address";
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 100,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RoundedButton(
                    text: "Submit",
                    press: () {
                      validCoowner();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 33,
              ),
            ],
          ),
        ),
      ),
    );
  }

  validCoowner() {
    var valid = _formKey.currentState!.validate();
    if (valid) {
      addCoWner();
    } else {
      return null;
    }
  }
}
