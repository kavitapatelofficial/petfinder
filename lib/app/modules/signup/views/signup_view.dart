// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petapp/app/component/buttons/defaultbutton.dart';
import 'package:petapp/app/component/buttons/upload_chip_button.dart';
import 'package:petapp/app/component/headings/my_headingtext.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/textthem.dart';
import 'package:petapp/app/model/createpet_response.dart';
import 'package:petapp/app/model/messge_model.dart';
import 'package:petapp/app/modules/signup/views/signup_screen_two.dart';
import 'package:petapp/app/modules/signup/views/signup_six.dart';
import 'package:petapp/app/modules/signup/views/statusbar.dart';
import 'package:petapp/services/base_client.dart';

import '../../../component/textformfields/fixed_label_textformfiled.dart';

import 'package:http/http.dart' as http;

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController uploadidNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  String phone = "";
  String? idproof;
  File? upload_idproof;
  bool isloading = false;

  _getdocuments() async {
    var result = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );

    if (result != null) {
      var file = File(result.path);
      setState(() {
        upload_idproof = file;
        uploadidNameController.text = upload_idproof!.path.split("/").last;
      });

      Navigator.of(context).pop();
    } else {
      // User canceled the picker
    }
  }

  signup1() async {
    print("pet created= pet id===${BaseClient.box2.read("pet_id")}");
    try {
      setState(() {
        isloading = true;
      });
      var headers = {
        'Authorization': 'Bearer ${BaseClient.box2.read("logintoken")}',
        'Content-Type': 'application/json'
      };
      print("=======headers========$headers====");
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://petfinder.booksica.in/pet/create'));
      request.fields.addAll({
        'rfid': phoneController.text,
        "id": BaseClient.box2.read("user_id")
      });

      if (upload_idproof!.path.isNotEmpty) {
        request.files.add(
            await http.MultipartFile.fromPath('file', upload_idproof!.path));
      }
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data1 = await response.stream.bytesToString();
        var response2 = messageModelFromJson(data1);

        // print(await response.stream.bytesToString());

        print("pet created= pet id===${BaseClient.box2.read("pet_id")}");
        setState(() {
          isloading = false;
        });

        if (response2.success == false) {
          setState(() {
            isloading = false;
          });
          Fluttertoast.showToast(
            msg: "${response2.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: AppColor.neturalRed,
            textColor: Colors.white,
          );
        } else {
          var data = createPetModelFromJson(data1);
          print("pet created====$data====$data1");
          BaseClient.box2.write("pet_id", data.data!.id);

          setState(() {
            isloading = false;
          });
          Fluttertoast.showToast(
            msg: "Pet created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: AppColor.neturalGreen,
            textColor: Colors.white,
          );
          // Get.offAll(const SignupViewTwo());
          Get.offAll(const SignupViewSix());
        }
      } else {
        setState(() {
          isloading = false;
        });
        print(response.reasonPhrase);
      }
    } finally {
      setState(() {
        isloading = false;
      });
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
                const SizedBox(
                  height: 50,
                ),
                const MyHeadingText(text: "Sign Up"),
                const SizedBox(
                  height: 24,
                ),
                const StatusBar(
                  status: '1',
                ),
                const SizedBox(
                  height: 37,
                ),
                const MyHeadingTwoText(
                    text: "Scan the Chip and enter the RFID number"),
                const SizedBox(
                  height: 54,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Image.asset(
                    "assets/images/pet6.png",
                    height: 204,
                    width: 213,
                    // color: AppColor.accentLightGrey,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                UploadChipButton(
                  press: () {
                    _uploadocumen(context);
                  },
                  text: "Upload Chip Certificate",
                  showicon: true,
                ),
                uploadidNameController.text.isNotEmpty
                    ? Padding(
                        padding:
                            const EdgeInsets.only(top: 8, left: 40, right: 40),
                        child: Text(
                          uploadidNameController.text,
                          style: Texttheme.title.copyWith(color: Colors.blue),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 53),
                    child: FixedLabelTextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        hintText: '123-32xxx',
                        labelText: 'RFID Number',
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                          });
                        },
                        icon: phone.isEmpty
                            ? const SizedBox()
                            : Image.asset(
                                "assets/images/icon.png",
                                height: 6,
                                width: 6,
                              )),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 53),
                    child: isloading
                        ? Container(
                            height: 60,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ))
                        : RoundedButton(
                            text: "Proceed",
                            press: () {
                              validateSignUp();
                              // Get.offAll(SignupViewTwo());
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

  void _uploadocumen(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              const SizedBox(height: 20),
              ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Pick Document',
                      style: Texttheme.title.copyWith(color: Colors.blue),
                    ),
                  ),
                  onTap: () async {
                    _getdocuments();
                  }),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        );
      },
    );
  }

  void validateSignUp() {
    print(
        "=====phone====$phone======${phoneController.text.length == 10}========");

    if (upload_idproof != null) {
      if (phoneController.text.isNotEmpty) {
        print(phoneController.text);

        signup1();
      } else {
        Fluttertoast.showToast(
          msg: "Please enter RFID number",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColor.neturalRed,
          textColor: Colors.white,
        );
        return;
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please upload chip certificate",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColor.neturalRed,
        textColor: Colors.white,
      );
      return;
    }
  }
}
