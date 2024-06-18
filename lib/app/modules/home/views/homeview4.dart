import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:petapp/app/component/appbars/custom_appbar.dart';
import 'package:petapp/app/component/buttons/defaultbutton.dart';
import 'package:petapp/app/component/buttons/oulined_button.dart';
import 'package:petapp/app/constent/api_urls.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/static_images.dart';
import 'package:petapp/app/model/all_pet_model.dart';
import 'package:petapp/app/modules/find/views/find_view_screen.dart';
import 'package:petapp/app/modules/find/views/pet_tabbar_screen.dart';
import 'package:petapp/app/modules/find/views/uploadvaccinecertifiaction.dart';
import 'package:petapp/app/modules/home/views/home_view2.dart';
import 'package:petapp/app/modules/owner/views/owner_view.dart';
import 'package:petapp/services/base_client.dart';

class Homeview4 extends StatefulWidget {
  int? currentIndex;
  Homeview4({Key? key, this.currentIndex}) : super(key: key);

  @override
  State<Homeview4> createState() => _Homeview4State();
}

class _Homeview4State extends State<Homeview4> with TickerProviderStateMixin {
  late TabController tabController;
  bool firstBuild = true;
  AllPetModel? allPetModel;
  var petname = "";
  var petid = "";
  var vaccineID = "";
  bool iscerti = false;
  bool isLoading = true;
  BaseClient baseClient = BaseClient();

  getallpet() async {
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "${ConstantsUrls.getAllPetByUser}${BaseClient.box2.read("user_id")}");
    if (response != null) {
      allPetModel = allPetModelFromJson(response);
      for (int i = 0; i < allPetModel!.result!.length; i++) {
        var vaccCount = allPetModel!.result![i].vaccine!.length;
        var petid1 = allPetModel!.result![i].id;
        var petname1 = allPetModel!.result![i].name;

        for (int j = 0; j < vaccCount; j++) {
          var pet = allPetModel!.result![i].vaccine![0].certificate == null
              ? ""
              : allPetModel!.result![i].vaccine![0].certificate;

          print(
              "======= pet certficate=================$pet=======================");

          print(
              "======= pet petname=================$petname1=======================");

          print(
              "======= pet certficate=================$petid=======================");
          String vaccID1 = allPetModel!.result![i].vaccine![j].id.toString();

          if (pet!.isEmpty) {
            setState(() {
              iscerti = true;
              petid = petid1!;
              petname = petname1!;
              vaccineID = vaccID1;
            });

            break;
          } else if (pet == null) {
            setState(() {
              iscerti = true;
              petid = petid1!;
              petname = petname1!;
              vaccineID = vaccID1;
            });

            break;
          }
        }
      }

      print("=========show dialog==========================");
    }

    setState(() {});
  }

  @override
  void initState() {
    getallpet();
    BaseClient.box2.write("is_full_detail_completed", true);
    super.initState();
    tabController = TabController(
      initialIndex: widget.currentIndex == null ? 0 : widget.currentIndex!,
      length: 3,
      vsync: this,
    );
  }

  _showOpenDialog(context) {
    var size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          // backgroundColor: Colors.transparent,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "You are yet to vaccinate $petname. Please vaccinate him at the earliest",
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                "assets/images/dialog.png",
                height: 146,
                width: 146,
              )
            ],
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RoundedButton(
                    text: "Yes",
                    press: () {
                      Get.to(UploadVaccineCertifaication(
                        petId: petid,
                        vaccineID: vaccineID,
                        petName: petname,
                      ));
                    },
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: OutlinedRoundedButton(
                    text: "Already vaccinated",
                    press: () {
                      // Get.offAll(Homeview4Two(
                      //   currentIndex: 1,
                      // ));
                      // Get.back();
                      // // setState(() {
                      // //   firstBuild = false;
                      // // });
                    },
                  ),
                ),
              ],
            )
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

  var children = [
    PageViewScreen(),
    // FindView(),
    PetTabbarScreen(),
    // SignupViewSix(),
    OwnerView(),
    // SignupViewTwo(),
  ];

  void onTapped(int i) {
    setState(() {
      widget.currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (firstBuild) {
    //     if (iscerti) {
    //       firstBuild = false;
    //       _showOpenDialog(context);
    //     }
    //   }
    // });
    return Scaffold(
      appBar: CustomAppBar(Constants.APPNAME),
      backgroundColor: AppColor.accentWhite,
      extendBody: true,
      body: children[widget.currentIndex == null ? 0 : widget.currentIndex!],
      bottomNavigationBar: BottomAppBar(
        color: AppColor.accentWhite,
        clipBehavior: Clip.antiAlias,
        child: BottomNavigationBar(
          // unselectedLabelStyle:
          //     const TextStyle(color: Colors.white, fontSize: 14),
          // backgroundColor: const Color(0xFF084A76),
          // fixedColor: AppColor.primaryColor,
          // unselectedItemColor: Colors.black,
          selectedLabelStyle: TextStyle(color: AppColor.primaryColor),

          // selectedLabelStyle: TextStyle(color: AppColor.neturalGreen),
          // type: BottomNavigationBarType.fixed,
          // selectedItemColor: AppColor.pinkColor,
          onTap: onTapped,
          // currentIndex: widget.currentIndex,
          // backgroundColor: AppColor.accentWhite,
          // unselectedItemColor: AppColor.defaultBlackColor,

          unselectedItemColor: Colors.red,
          unselectedFontSize: 14,

          items: [
            BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Image.asset("assets/Home/home2.png",
                            height: 24,
                            width: 24,
                            color: widget.currentIndex == 0
                                ? AppColor.primaryColor
                                : Colors.black),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: CircleAvatar(
                                radius: 6,
                                backgroundColor: AppColor.accentWhite,
                                child: Icon(Icons.search,
                                    size: 15,
                                    color: widget.currentIndex == 0
                                        ? AppColor.primaryColor
                                        : Colors.black)))
                      ],
                    ),
                    Text(
                      "Find",
                      style: TextStyle(
                        color: widget.currentIndex == 0
                            ? AppColor.primaryColor
                            : Colors.black,
                        fontFamily: "Lato",
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/paw55.png",
                        height: 24,
                        width: 24,
                        color: widget.currentIndex == 1
                            ? AppColor.primaryColor
                            : Colors.black),
                    Text(
                      "Pet",
                      style: TextStyle(
                        color: widget.currentIndex == 1
                            ? AppColor.primaryColor
                            : Colors.black,
                        fontFamily: "Lato",
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset("assets/Home/user.png",
                        height: 24,
                        width: 24,
                        color: widget.currentIndex == 2
                            ? AppColor.primaryColor
                            : Colors.black),
                    Text(
                      "Owner",
                      style: TextStyle(
                        color: widget.currentIndex == 2
                            ? AppColor.primaryColor
                            : Colors.black,
                        fontFamily: "Lato",
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
                label: "")
          ],
        ),
      ),
    );
  }
}
