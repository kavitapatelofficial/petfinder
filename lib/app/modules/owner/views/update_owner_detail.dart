// ignore_for_file: non_constant_identifier_names, empty_statements, unused_local_variable, prefer_const_constructors

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:get/get.dart';
import 'package:petapp/app/model/update_user.dart';
import 'package:petapp/app/model/user_detail_model.dart';
import 'package:petapp/app/modules/home/views/home_view.dart';
import 'package:petapp/app/modules/home/views/home_view3.dart';

import '../../../../services/base_client.dart';
import '../../../component/buttons/defaultbutton.dart';
import '../../../component/headings/my_headingtext.dart';
import '../../../component/textformfields/my_textform_field.dart';
import '../../../constent/api_urls.dart';
import '../../../constent/colors.dart';
import '../../../constent/textthem.dart';

class AddOwnerDetail extends StatefulWidget {
  final String userID;
  const AddOwnerDetail({Key? key, required this.userID}) : super(key: key);

  @override
  State<AddOwnerDetail> createState() => _AddOwnerDetailState();
}

class _AddOwnerDetailState extends State<AddOwnerDetail> {
  bool? _value = false;
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

  final _formKey = GlobalKey<FormState>();
  BaseClient baseClient = BaseClient();
  // ? signupModel;
  bool isLoading = true;
  String? stateseleted;
  String? stateseleted2;

  UserDetailModel? user;
  bool isOwLoading = true;

  getcoOwner() async {
    isLoading = true;
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "${ConstantsUrls.getUser}${widget.userID}");
    user = userDetailModelFromJson(response);
    if (user!.user != null) {
      nameController.text = user!.user!.name ?? "";
      phoneController.text = user!.user!.phoneNumber.toString() ?? "";
      emailController.text = user!.user!.email ?? "";
      CpincodeController.text = "${user!.user!.currentAddress!.zip ?? ""}";
      CcityController.text = user!.user!.currentAddress!.city ?? "";
      stateseleted = user!.user!.currentAddress!.state!.isEmpty
          ? "Madhya Pradesh"
          : user!.user!.currentAddress!.state!;
      CaddressController.text = user!.user!.currentAddress!.add ?? "";
      ;
      PpincodeController.text = "${user!.user!.permanentAddress!.zip ?? ""}";
      PcityController.text = user!.user!.permanentAddress!.city ?? "";
      stateseleted2 = user!.user!.permanentAddress!.state!.isEmpty
          ? "Madhya Pradesh"
          : user!.user!.permanentAddress!.state!;
      PaddressController.text = user!.user!.permanentAddress!.add ?? "";
      isOwner = user!.user!.isOwner == null ? false : user!.user!.isOwner!;
    }
    isLoading = false;
    setState(() {});
  }

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

  List state2 = [
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

  updateOwner() async {
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
      }
    };

    print("data===$data");
    final apiResponse = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(baseClient.put(
        true,
        ConstantsUrls.baseURL,
        "${ConstantsUrls.updateUser}${widget.userID}",
        data,
      )),
    );

    print("apiRespons==$apiResponse");

    if (apiResponse != null) {
      var response = updateUserModelFromJson(apiResponse);
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
        // BaseClient.box2.write("user_id", data.user!.id);
        Fluttertoast.showToast(
          msg: "${response.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
        Get.offAll(HomeViewThree(
          currentIndex: 2,
        ));
      }
    }
  }

  @override
  void initState() {
    getcoOwner();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return SafeArea(
      child: Scaffold(
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
                    const SizedBox(
                      height: 37,
                    ),
                    const MyHeadingTwoText(text: "Personal Details "),
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
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: MyTextFormField(
                              controller: nameController,
                              hintText: 'Name',
                              // labelText: 'Name',
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
                    SizedBox(
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
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: MyTextFormField(
                            read: true,
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            hintText: 'Phone',
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Phone required";
                              } else if (value.length != 10) {
                                return "Phone required";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
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
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: MyTextFormField(
                              hintText: 'Current Address',
                              controller: CaddressController,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: MyTextFormField(
                            hintText: 'City',
                            controller: CcityController,
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
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
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
                                CstateController.text = stateseleted!;
                              });
                              //Do something when changing the item if you want.
                            },
                            onSaved: (value) {
                              setState(() {
                                stateseleted = value.toString();
                                CstateController.text = stateseleted!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: MyTextFormField(
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
                    SizedBox(
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
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: MyTextFormField(
                              keyboardType: TextInputType.emailAddress,
                              hintText: 'Email',
                              controller: emailController,
                              validate: (value) {
                                final bool isValid =
                                    EmailValidator.validate(value!);
                                if (value.isEmpty) {
                                  return "Enter email address";
                                } else if (isValid == false) {
                                  return "Enter valid emailaddres";
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
                                PstateController.text = CstateController.text;
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
                            padding: EdgeInsets.all(3),
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
                                : SizedBox(),
                          ),
                        ),
                        SizedBox(
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: AppColor.accentLightGrey,
                                        size: 33,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: MyTextFormField(
                                          hintText: 'Permanent Address',
                                          controller: PaddressController,
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 40,
                                    ),
                                    Expanded(
                                      child: MyTextFormField(
                                        hintText: 'City',
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
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
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
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xffE5E4F2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: const Color(0xffE5E4F2),
                                          enabledBorder: OutlineInputBorder(
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
                                        items: state2
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(
                                                    item,
                                                    style: const TextStyle(
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
                                            stateseleted2 = value.toString();
                                            PstateController.text =
                                                stateseleted2!;
                                          });
                                          //Do something when changing the item if you want.
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            stateseleted2 = value.toString();
                                            PstateController.text =
                                                stateseleted2!;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: MyTextFormField(
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
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    const SizedBox(
                      height: 28,
                    ),
                    RoundedButton(
                      text: "Update",
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
            ),
          )),
    );
  }

  void updateUser() {
    var data = {
      "data": {
        "name": nameController.text,
        "email": emailController.text,
        "phone": phoneController.text,
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

    setState(() {});

    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();

      var data = {
        "data": {
          "name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
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

      updateOwner();
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
      shape: RoundedRectangleBorder(
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
      shape: RoundedRectangleBorder(
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
}
