// ignore_for_file: non_constant_identifier_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

import 'package:get/get.dart';
import 'package:petapp/app/component/buttons/defaultbutton.dart';
import 'package:petapp/app/component/buttons/upload_chip_button.dart';
import 'package:petapp/app/component/headings/my_headingtext.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/textthem.dart';
import 'package:petapp/app/model/update_user.dart';
import 'package:email_validator/email_validator.dart';

import 'package:petapp/app/modules/signup/views/statusbar.dart';

import '../../../../services/base_client.dart';
import '../../../component/textformfields/my_textform_field.dart';

class SignupViewTwo extends StatefulWidget {
  const SignupViewTwo({Key? key}) : super(key: key);

  @override
  State<SignupViewTwo> createState() => _SignupViewTwoState();
}

class _SignupViewTwoState extends State<SignupViewTwo> {
  bool? _value = false;
  bool? _coowner = false;
  int phone = 0;

  bool isOwner = true;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController CaddressController = TextEditingController();
  final TextEditingController CstateController = TextEditingController();
  final TextEditingController CcityController = TextEditingController();
  final TextEditingController CpincodeController = TextEditingController();

  final TextEditingController PaddressController = TextEditingController();
  final TextEditingController PstateController = TextEditingController();
  final TextEditingController PcityController = TextEditingController();
  final TextEditingController PpincodeController = TextEditingController();

  final TextEditingController CownerphoneController = TextEditingController();
  final TextEditingController CownernameController = TextEditingController();
  final TextEditingController CowneremailController = TextEditingController();

  final TextEditingController userTypeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  BaseClient baseClient = BaseClient();
  // ? signupModel;
  bool isLoading = false;

  var stateseleted;
  var stateseleted2;

  List state = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttarakhand",
    "Uttar Pradesh",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Delhi",
    "Lakshadweep",
    "Puducherry"
  ];

  signup3() async {
    try {
      isLoading = true;
      var data = {
        "data": {
          "name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "isOwner": isOwner,
          "currentAddress": {
            "add": CaddressController.text,
            "city": CcityController.text,
            "state": CstateController.text,
            "zip": CpincodeController.text
          },
          "permanentAddress": {
            "add": PaddressController.text,
            "city": PcityController.text,
            "state": PstateController.text,
            "zip": PpincodeController.text
          },
          "coOwner": {
            "name": CownernameController.text,
            "email": CowneremailController.text,
            "phone": CownerphoneController.text.isEmpty
                ? ""
                : int.parse(CownerphoneController.text).toInt(),
          }
        }
      };

      var data2 = {
        "data": {
          "name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "isOwner": isOwner,
          "currentAddress": {
            "add": CaddressController.text,
            "city": CcityController.text,
            "state": CstateController.text,
            "zip": CpincodeController.text
          },
          "permanentAddress": {
            "add": PaddressController.text,
            "city": PcityController.text,
            "state": PstateController.text,
            "zip": PpincodeController.text
          },
        }
      };

      final apiResponse = await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(baseClient.put(
          true,
          "https://petfinder.booksica.in/",
          "api/updateUser/${BaseClient.box2.read("user_id")}",
          CownerphoneController.text.isNotEmpty ? data : data2,
        )),
      );

      if (apiResponse != null) {
        var response = updateUserModelFromJson(apiResponse);
        setState(() {
          isLoading = false;
        });
        if (response.success == false) {
          // phoneController.text = "";
          Fluttertoast.showToast(
            msg: "${response.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 2,
            backgroundColor: AppColor.neturalRed,
            textColor: Colors.white,
          );
        } else {
          var data = updateUserModelFromJson(apiResponse);
          BaseClient.box2.write("user_id", data.doc!.id);
          BaseClient.box2.write("name", data.doc!.name);
          setState(() {
            isLoading = false;
          });
          Fluttertoast.showToast(
            msg: "${response.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          // Get.offAll(const SignupViewSix());
          // Get.to(const SignupViewFour());
          Get.offNamedUntil("/home", (route) => false);
        }
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    phoneController.text =
        "${BaseClient.box2.read("phone") == null ? "" : BaseClient.box2.read("phone")}";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    phoneController.text =
        "${BaseClient.box2.read("phone") == null ? "" : BaseClient.box2.read("phone")}";
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.accentWhite,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(),
                        const MyHeadingText(text: "Sign Up"),
                        const SizedBox(
                          height: 24,
                        ),
                        const StatusBar(
                          status: '2',
                        ),
                        const SizedBox(
                          height: 37,
                        ),
                        const MyHeadingTwoText(text: "Personal Details"),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "*As per the name in dog’s vaccination record",
                              textAlign: TextAlign.end,
                              style: Texttheme.bodyText1.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: screenSize.width,
                          child: Row(
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
                                  controller: nameController,
                                  hintText: 'Name',
                                  keyboardType: TextInputType.name,
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
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: screenSize.width,
                          child: Row(
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
                                  read: true,
                                  controller: phoneController,
                                  keyboardType: TextInputType.phone,
                                  hintText: 'Phone',
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
                        ),
                        //  const SizedBox(
                        //   height: 16,
                        // ),
                        // SizedBox(
                        //   width: screenSize.width,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: [
                        //       Icon(
                        //         Icons.person,
                        //         color: AppColor.accentLightGrey,
                        //         size: 33,
                        //       ),
                        //       const SizedBox(
                        //         width: 8,
                        //       ),
                        //       Expanded(
                        //         child: MyTextFormField(
                        //           icon: IconButton(
                        //               onPressed: () {
                        //                 _userTypePicker(context);
                        //               },
                        //               icon: Icon(Icons.arrow_drop_down)),
                        //           read: true,
                        //           controller: userTypeController,
                        //           keyboardType: TextInputType.phone,
                        //           hintText: 'UserType',
                        //           validate: (value) {
                        //             if (value!.isEmpty) {
                        //               return "userType required";
                        //             }
                        //             return null;
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: screenSize.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: AppColor.accentLightGrey,
                                size: 33,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: MyTextFormField(
                                  hintText: 'Current Address',
                                  controller: CaddressController,
                                  keyboardType: TextInputType.streetAddress,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return "Current Address required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                child: MyTextFormField(
                                  hintText: 'City',
                                  controller: CcityController,
                                  keyboardType: TextInputType.name,
                                  validate: (value) {
                                    if (value!.isEmpty) {
                                      return "Current city required";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 40,
                              ),
                              Expanded(
                                child: DropdownButtonFormField2(
                                  decoration: InputDecoration(
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xffE5E4F2),
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xffE5E4F2),
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: const Color(0xffE5E4F2),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xffE5E4F2),
                                      ),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    //Add isDense true and zero Padding.
                                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,

                                    //Add more decoration as you want here
                                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                  ),
                                  isExpanded: true,
                                  hint: const Text(
                                    'State',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  icon: const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 30,
                                  buttonHeight: 50,
                                  // buttonPadding: const EdgeInsets.only(
                                  //     left: 20, right: 10),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  items: state
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: stateseleted,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select state';
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      stateseleted = value.toString();
                                      CstateController.text = stateseleted;
                                    });
                                    //Do something when changing the item if you want.
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      stateseleted = value.toString();
                                      CstateController.text = stateseleted;
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: MyTextFormField(
                                  maxLength: 6,
                                  keyboardType: TextInputType.phone,
                                  hintText: 'Zip',
                                  controller: CpincodeController,
                                  validate: (value) {
                                    bool isZipValid = RegExp(
                                            r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$",
                                            caseSensitive: false)
                                        .hasMatch(value!);
                                    if (isZipValid == false) {
                                      return "Enter valid zip code";
                                    } else if (value.length != 6) {
                                      return "Enter valid zip code";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          width: screenSize.width,
                          child: Row(
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
                                    if (value.isEmpty) {
                                      return "Please Enter email";
                                    } else if (isValid == false) {
                                      return "Please Enter valid email";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (_value == false) {
                                  setState(() {
                                    _value = true;
                                    PaddressController.text =
                                        CaddressController.text;
                                    PcityController.text = CcityController.text;
                                    PstateController.text =
                                        CstateController.text;
                                    PpincodeController.text =
                                        CpincodeController.text;
                                  });
                                } else {
                                  setState(() {
                                    _value = false;
                                    PpincodeController.text = "";
                                    PcityController.text = "";
                                    PstateController.text = "";
                                    PaddressController.text = "";
                                  });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: _value == true
                                        ? AppColor.defaultBlackColor
                                        : AppColor.accentWhite,
                                    border: Border.all()),
                                child: _value == true
                                    ? Center(
                                        child: Image.asset(
                                        "assets/Home/check.png",
                                        color: AppColor.accentWhite,
                                      ))
                                    : const SizedBox(),
                              ),
                            ),
                            const SizedBox(
                              width: 22,
                            ),
                            Expanded(
                                child: Text(
                              "Is your Permanent address same as Current Address",
                              style: Texttheme.bodyText1,
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        _value == false
                            ? Container(
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: screenSize.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.location_on,
                                            color: AppColor.accentLightGrey,
                                            size: 33,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Expanded(
                                            child: MyTextFormField(
                                              hintText: 'Permanent Address',
                                              controller: PaddressController,
                                              keyboardType:
                                                  TextInputType.streetAddress,
                                              validate: (value) {
                                                if (value!.isEmpty) {
                                                  return "Permanent Address required";
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          Expanded(
                                            child: MyTextFormField(
                                              hintText: 'City',
                                              keyboardType: TextInputType.name,
                                              controller: PcityController,
                                              validate: (value) {
                                                if (value!.isEmpty) {
                                                  return "Permanent city required";
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            width: 40,
                                          ),
                                          Expanded(
                                            child: DropdownButtonFormField2(
                                              decoration: InputDecoration(
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xffE5E4F2),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xffE5E4F2),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                ),
                                                border: InputBorder.none,
                                                filled: true,
                                                fillColor:
                                                    const Color(0xffE5E4F2),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xffE5E4F2),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                ),
                                                //Add isDense true and zero Padding.
                                                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                isDense: true,
                                                contentPadding: EdgeInsets.zero,

                                                //Add more decoration as you want here
                                                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                              ),
                                              isExpanded: true,
                                              hint: const Text(
                                                'State',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              icon: const Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black45,
                                              ),
                                              iconSize: 30,
                                              buttonHeight: 50,
                                              // buttonPadding:
                                              //     const EdgeInsets.only(
                                              //         left: 20, right: 10),
                                              dropdownDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              items: state
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              value: stateseleted2,
                                              validator: (value) {
                                                if (value == null) {
                                                  return 'Please select state';
                                                }
                                              },
                                              onChanged: (value) {
                                                setState(() {
                                                  stateseleted2 =
                                                      value.toString();
                                                  PstateController.text =
                                                      stateseleted2;
                                                });
                                                //Do something when changing the item if you want.
                                              },
                                              onSaved: (value) {
                                                setState(() {
                                                  stateseleted2 =
                                                      value.toString();
                                                  PstateController.text =
                                                      stateseleted2;
                                                });
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: MyTextFormField(
                                              maxLength: 6,
                                              keyboardType: TextInputType.phone,
                                              hintText: 'Zip',
                                              controller: PpincodeController,
                                              validate: (value) {
                                                bool isZipValid = RegExp(
                                                        r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$",
                                                        caseSensitive: false)
                                                    .hasMatch(value!);
                                                if (isZipValid == false) {
                                                  return "Enter valid zip code";
                                                } else if (value.length != 6) {
                                                  return "Enter valid zip code";
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  _coowner == true
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const MyHeadingTwoText(text: "Co-Owner Details"),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: screenSize.width,
                              child: Row(
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
                                      controller: CownernameController,
                                      keyboardType: TextInputType.name,
                                      validate: (value) {
                                        if (value!.isNotEmpty) {
                                          if (value.isEmpty) {
                                            return;
                                          } else {
                                            return null;
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: screenSize.width,
                              child: Row(
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
                                      controller: CownerphoneController,
                                      keyboardType: TextInputType.phone,
                                      validate: (value) {
                                        if (value!.isNotEmpty) {
                                          if (value.isEmpty) {
                                            return "Co- Owner Phone required";
                                          } else if (value.length != 10) {
                                            return "Enter valid phone number";
                                          } else {
                                            return null;
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            SizedBox(
                              width: screenSize.width,
                              child: Row(
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
                                      controller: CowneremailController,
                                      keyboardType: TextInputType.emailAddress,
                                      validate: (value) {
                                        if (value!.isNotEmpty) {
                                          final bool isValid =
                                              EmailValidator.validate(value);
                                          if (value.isEmpty) {
                                            return "Enter email address";
                                          } else if (isValid == false) {
                                            return "Enter valid email address";
                                          } else {
                                            return null;
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        )
                      : InkWell(
                          onTap: () {
                            if (_coowner == false) {
                              setState(() {
                                _coowner = true;
                              });
                            } else {
                              setState(() {
                                _coowner = false;
                              });
                            }
                          },
                          child: const UploadChipButton(
                            text: "Add a Co-owner ",
                            showicon: false,
                          ),
                        ),
                  const SizedBox(
                    height: 28,
                  ),
                  isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : RoundedButton(
                          text: "Proceed",
                          press: () async {
                            updateUser();
                            // Get.offAll(SignupViewFour());
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

  void updateUser() {
    setState(() {});

    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();

      signup3();
    } else {
      Fluttertoast.showToast(
        msg: "Red highlighted field required",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColor.neturalRed,
        textColor: Colors.white,
      );
      return;
    }
  }

  void _selectState(context) {
    showModalBottomSheet(
      // isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
                children: state.map((e) {
              return ListTile(
                  title: Text(
                    '$e',
                    style: Texttheme.title,
                  ),
                  onTap: () async {
                    // _getdocuments();
                    setState(() {
                      CstateController.text = e;
                    });
                    Navigator.of(context).pop();
                  });
            }).toList()),
          ),
        );
      },
    );
  }

  void _selectPState(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Wrap(
                children: state.map((e) {
              return ListTile(
                  title: Text(
                    '$e',
                    style: Texttheme.title,
                  ),
                  onTap: () async {
                    // _getdocuments();
                    setState(() {
                      PstateController.text = e;
                    });
                    Navigator.of(context).pop();
                  });
            }).toList()),
          ),
        );
      },
    );
  }

  void _userTypePicker(context) {
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
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Guardian(legal owner)',
                      style: Texttheme.title,
                    ),
                  ),
                  onTap: () async {
                    setState(() {
                      isOwner = true;
                      userTypeController.text = "Guardian(legal owner)";
                    });
                    Navigator.of(context).pop();
                  }),
              ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Volunteer',
                      style: Texttheme.title,
                    ),
                  ),
                  onTap: () async {
                    setState(() {
                      isOwner = false;
                      userTypeController.text = "Volunteer";
                    });
                    Navigator.of(context).pop();
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
}
