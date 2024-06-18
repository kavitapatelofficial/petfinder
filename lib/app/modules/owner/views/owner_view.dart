import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petapp/app/constent/api_urls.dart';
import 'package:petapp/app/model/all_co_owner_model.dart';
import 'package:petapp/app/model/common_error_model.dart';
import 'package:petapp/app/modules/owner/views/add_co_owner_deatil.dart';

import 'package:petapp/app/modules/owner/views/first_owner_screen.dart';
import 'package:petapp/app/modules/owner/views/second_owner_screen.dart';

import '../../../../services/base_client.dart';
import '../../../constent/colors.dart';
import '../../../constent/textthem.dart';

class OwnerView extends StatefulWidget {
  int? currentIndex;
  OwnerView({Key? key, this.currentIndex}) : super(key: key);

  @override
  State<OwnerView> createState() => _OwnerViewState();
}

class _OwnerViewState extends State<OwnerView> with TickerProviderStateMixin {
  late TabController tabController;
  BaseClient baseClient = BaseClient();
  AllCoOwnerModel? allCoOwnerModel;
  CommonErrorModel? commonErrorModel;
  bool isLoading = true;

  bool isCooWner = false;

  @override
  void initState() {
    getcoOwner();
    super.initState();
  }

  void onTapped(int i) {
    setState(() {
      widget.currentIndex = i;
    });
  }

  getcoOwner() async {
    try {
      isLoading = true;
      var response = await baseClient.get(false, ConstantsUrls.baseURL,
          "/api/getCoowner/${BaseClient.box2.read("user_id")}");

      if (response == 400) {
        print("=============response========$response====${response == 400}==");
        print("==========================");

        // commonErrorModel = commonErrorModelFromJson(response);
      } else {
        setState(() {
          isCooWner = true;
        });
        print("=============response========$response====${response == 400}==");
        allCoOwnerModel = allCoOwnerModelFromJson(response);
      }
    } finally {
      isLoading = false;
      setState(() {});

      tabController = TabController(
        initialIndex: widget.currentIndex == null ? 0 : widget.currentIndex!,
        length: isCooWner == false ? 1 : 2,
        vsync: this,
      );
    }
  }

  SliverAppBar showSliverAppBar() {
    return SliverAppBar(
      backgroundColor: AppColor.accentWhite,
      elevation: 0,
      expandedHeight: 50.0,
      floating: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Padding(
          padding: EdgeInsets.only(
              left: BaseClient.box2.read("userLogin") == false ? 0 : 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BaseClient.box2.read("userLogin") == false
                  ? const SizedBox(
                      height: 50,
                      width: 0,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(AddCoOwnerDetails());
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            margin: const EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              color: AppColor.accentLightGrey,
                              borderRadius: BorderRadius.circular(
                                  10), //border corner radius
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 1, //spread radius
                                  blurRadius: 1, // blur radius
                                  offset: const Offset(
                                      0, 0.2), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                ),
                                //you can set more BoxShadow() here
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Add",
                          style: Texttheme.title,
                        ),
                        const SizedBox(
                          height: 3.5,
                        ),
                      ],
                    ),

              BaseClient.box2.read("userLogin") == false
                  ? SizedBox(
                      width: 0,
                    )
                  : SizedBox(
                      width: 15,
                    ),

              isCooWner == false
                  ? Expanded(
                      child: TabBar(
                        controller: tabController,
                        padding: EdgeInsets.zero,
                        indicatorColor: AppColor.primaryColor,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        labelColor: Colors.black,
                        labelStyle:
                            Texttheme.title.copyWith(color: Colors.black),
                        tabs: [
                          Tab(
                            iconMargin: const EdgeInsets.only(bottom: 10),
                            height: 100,
                            icon: Container(
                                height: 50,
                                width: 63,
                                margin: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color: AppColor.neturalYellow,
                                  borderRadius: BorderRadius.circular(
                                      10), //border corner radius
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), //color of shadow
                                      spreadRadius: 1, //spread radius
                                      blurRadius: 1, // blur radius
                                      offset: const Offset(
                                          0, 0.2), // changes position of shadow
                                      //first paramerter of offset is left-right
                                      //second parameter is top to down
                                    ),
                                    //you can set more BoxShadow() here
                                  ],
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.person,
                                  color: AppColor.accentWhite,
                                  size: 32,
                                ))),
                            text: 'Owner',
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: TabBar(
                        controller: tabController,
                        padding: EdgeInsets.zero,
                        indicatorColor: AppColor.primaryColor,
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicatorPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        labelColor: Colors.black,
                        labelStyle:
                            Texttheme.title.copyWith(color: Colors.black),
                        tabs: [
                          Tab(
                            iconMargin: const EdgeInsets.only(bottom: 10),
                            height: 100,
                            icon: Container(
                                height: 50,
                                width: 63,
                                margin: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                  color: AppColor.neturalYellow,
                                  borderRadius: BorderRadius.circular(
                                      10), //border corner radius
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), //color of shadow
                                      spreadRadius: 1, //spread radius
                                      blurRadius: 1, // blur radius
                                      offset: const Offset(
                                          0, 0.2), // changes position of shadow
                                      //first paramerter of offset is left-right
                                      //second parameter is top to down
                                    ),
                                    //you can set more BoxShadow() here
                                  ],
                                ),
                                child: Center(
                                    child: Icon(
                                  Icons.person,
                                  color: AppColor.accentWhite,
                                  size: 32,
                                ))),
                            text: 'Owner',
                          ),
                          Tab(
                            iconMargin: const EdgeInsets.only(bottom: 10),
                            height: 100,
                            icon: Container(
                              height: 50,
                              width: 63,
                              margin: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                color: HexColor("#F9A6AF"),
                                borderRadius: BorderRadius.circular(
                                    10), //border corner radius
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), //color of shadow
                                    spreadRadius: 1, //spread radius
                                    blurRadius: 1, // blur radius
                                    offset: const Offset(
                                        0, 0.2), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  color: AppColor.accentWhite,
                                  size: 32,
                                ),
                              ),
                            ),
                            text: 'Co-Owner',
                          )
                        ],
                      ),
                    ),
              // Spacer(
              //   flex: 1,
              // )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : DefaultTabController(
            length: isCooWner == false ? 1 : 2,
            child: Scaffold(
               backgroundColor: AppColor.accentWhite,
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    showSliverAppBar(),
                  ];
                },
                body: isCooWner == false
                    ? TabBarView(
                        controller: tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                            // This CustomScrollView display the Home tab content
                            CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildListDelegate(
                                      [const FirstOwner()]),
                                ),
                              ],
                            ),
                          ])
                    : TabBarView(
                        controller: tabController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                            // This CustomScrollView display the Home tab content
                            CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildListDelegate(
                                      [const FirstOwner()]),
                                ),
                              ],
                            ),

                            // This shows the Settings tab content
                            CustomScrollView(
                              slivers: [
                                SliverList(
                                  delegate: SliverChildListDelegate(
                                      [const SeconOwnerScreen()]),
                                ),
                              ],
                            )
                          ]),
              ),
            ));
  }
}
