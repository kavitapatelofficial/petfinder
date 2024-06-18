// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:petapp/app/component/buttons/defaultbutton.dart';
import 'package:petapp/app/component/headings/my_column_text.dart';
import 'package:petapp/app/component/headings/my_headingtext.dart';

import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/textthem.dart';
import 'package:petapp/app/model/pet_detail_model.dart';
import 'package:petapp/app/model/user_detail_model.dart';
import 'package:petapp/app/modules/home/views/home_view.dart';
import 'package:petapp/app/modules/home/views/home_view2.dart';
import 'package:petapp/app/modules/login/controllers/login_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../services/base_client.dart';
import '../../../constent/api_urls.dart';

// var dateFormate=DateFormat('yyyy-MM-dd')
//                 .format(DateTime.parse(petDetailModel!.data!.doB!));

class PetMissingDetail extends StatefulWidget {
  final String petId;
  const PetMissingDetail({Key? key, required this.petId}) : super(key: key);

  @override
  State<PetMissingDetail> createState() => _PetMissingDetailState();
}

class _PetMissingDetailState extends State<PetMissingDetail> {
  final TextEditingController noteController = TextEditingController();
  BaseClient baseClient = BaseClient();

  // ? signupModel;
  bool isLoading = false;
  UserDetailModel? userDetailModel;
  PetDetailModel? petDetailModel;

  getpet() async {
    isLoading = true;
    var url = ConstantsUrls.baseURL + ConstantsUrls.getAllPetByUser;
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "${ConstantsUrls.getPetById}${widget.petId}");
    if (response != null) {
      petDetailModel = petDetailModelFromJson(response);
      if (petDetailModel!.data != null) {
        noteController.text = petDetailModel!.data!.lastSeen == null
            ? ""
            : petDetailModel!.data!.lastSeen!.toString();
        var userId = petDetailModel!.data!.user;
        getuser(userId == null ? "0" : userId.toString());
      }
    }
  }

  getpet2() async {
    var url = ConstantsUrls.baseURL + ConstantsUrls.getAllPetByUser;
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "${ConstantsUrls.getPetById}${widget.petId}");
    if (response != null) {
      petDetailModel = petDetailModelFromJson(response);
      if (petDetailModel!.data != null) {
        var userId = petDetailModel!.data!.user;
        getuser(userId == null ? "0" : userId.toString());
      }
    }
  }

  getuser(String ownerID) async {
    var url = ConstantsUrls.baseURL + ConstantsUrls.getAllPetByUser;
    var response = await baseClient.get(
        false, ConstantsUrls.baseURL, "${ConstantsUrls.getUser}$ownerID");
    if (response != null) {
      userDetailModel = userDetailModelFromJson(response);
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getpet();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.offAll(HomeView(
                    currentIndex: 1,
                  ));
                },
                icon: Icon(Icons.arrow_back_ios)),
            iconTheme: IconThemeData(
              color: AppColor.primaryColor, //OR Colors.red or whatever you want
            ),
            elevation: 0,
            backgroundColor: AppColor.accentWhite,
          ),
          backgroundColor: AppColor.accentWhite,
          body: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "Missing Post",
                          style: Texttheme.title.copyWith(fontSize: 18),
                        ),
                      ),
                      MyHeadingText(
                          text: petDetailModel!.data!.name == null
                              ? ""
                              : petDetailModel!.data!.name!.toString()),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 26, vertical: 20),
                        alignment: Alignment.center,
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              onError: (exception, stackTrace) =>
                                  const Center(child: Icon(Icons.error)),
                              fit: BoxFit.cover,
                              image: NetworkImage(petDetailModel!.data!.photo ==
                                      null
                                  ? ""
                                  : (ConstantsUrls.baseURL +
                                      "/api/" +
                                      petDetailModel!.data!.photo.toString()))),
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(30), //border corner radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey
                                  .withOpacity(0.5), //color of shadow
                              spreadRadius: 1, //spread radius
                              blurRadius: 7, // blur radius
                              offset: const Offset(
                                  0, 0.2), // changes position of shadow
                              //first paramerter of offset is left-right
                              //second parameter is top to down
                            ),
                            //you can set more BoxShadow() here
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ColumnText(
                          text1: "Owner",
                          text2: userDetailModel!.user!.name == null
                              ? ""
                              : userDetailModel!.user!.name!.toString()),
                      ColumnText(
                          text1: "Pet Details",
                          text2: petDetailModel!.data!.name == null
                              ? ""
                              : petDetailModel!.data!.name!.toString()),
                      ColumnText(
                          text1: "Phone Number",
                          text2: userDetailModel!.user!.phoneNumber.toString() ==
                                  null
                              ? ""
                              : userDetailModel!.user!.phoneNumber.toString()),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          minLines: 1,
                          maxLines: null,
                          controller: noteController,
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 16,
                            color: HexColor("#828282"),
                            fontWeight: FontWeight.w400,
                          ),
                          onChanged: (value) {},
                          onFieldSubmitted: (value) {
                            if (noteController.text.isNotEmpty) {
                              writeNote(widget.petId);
                            } else {
                              Fluttertoast.showToast(
                                msg: "Please write something about pet",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.SNACKBAR,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                              );
                            }
                            return null;
                          },

                          decoration: InputDecoration(
                            filled: true,

                            isDense: true,
                            focusColor: Colors.white,
                            //add prefix icon
                            // ignore: prefer_const_constructors
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.asset(
                                "assets/Home/BallPen.png",
                                height: 6,
                                width: 6,
                              ),
                            ),

                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(4),
                            ),

                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,

                              // borderSide:  BorderSide(
                              //   color: HexColor("#40000000"),
                              // ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            fillColor: HexColor("#40000000").withOpacity(0.1),

                            hintText: "Write where your pet was seen last",

                            //make hint text
                            // ignore: prefer_const_constructors
                            hintStyle: TextStyle(
                              fontFamily: "Open Sans",
                              fontSize: 12,
                              color: HexColor("#000000"),
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                            ),

                            //create lable

                            //lable style
                            // ignore: prefer_const_constructors
                            labelStyle: TextStyle(
                              color: HexColor("#49454F"),
                              fontSize: 16,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 53),
                          child: RoundedButton(
                            text: "Submit",
                            press: () async {
                              var data = {"isMissing": true};

                              final apiResponse = await showDialog(
                                context: context,
                                builder: (context) =>
                                    FutureProgressDialog(baseClient.put(
                                  false,
                                  ConstantsUrls.baseURL,
                                  ConstantsUrls.petMissing + widget.petId,
                                  data,
                                )),
                              );

                              if (apiResponse != null) {
                                Fluttertoast.showToast(
                                  msg:
                                      "Your pet lost report successfuly submitted",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: AppColor.neturalGreen,
                                  textColor: Colors.white,
                                );
                                Get.offAll(HomeViewTwo(
                                  currentIndex: 1,
                                ));
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Something Wrong please try again..",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              }
                            },
                          )),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                )),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  writeNote(String petid) async {
    var data = {"missingNote": noteController.text};

    final apiResponse = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(baseClient.put(
        false,
        ConstantsUrls.baseURL,
        ConstantsUrls.writeLastSeenNote + petid,
        data,
      )),
    );

    if (apiResponse != null) {
      Fluttertoast.showToast(
        msg: "Your note successfuly submitted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColor.neturalGreen,
        textColor: Colors.white,
      );
      getpet2();
    } else {
      Fluttertoast.showToast(
        msg: "Something Wrong please try again..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }
}
