import 'package:flutter/material.dart';

import 'package:petapp/app/component/appbars/custom_appbar.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/static_images.dart';
import 'package:petapp/app/modules/find/views/find_view.dart';
import 'package:petapp/app/modules/find/views/find_view_screen.dart';
import 'package:petapp/app/modules/find/views/pet_tabbar_screen.dart';
import 'package:petapp/app/modules/owner/views/owner_view.dart';
import 'package:petapp/services/base_client.dart';

class HomeViewThree extends StatefulWidget {
  int? currentIndex;
  HomeViewThree({Key? key, this.currentIndex}) : super(key: key);

  @override
  State<HomeViewThree> createState() => _HomeViewThreeState();
}

class _HomeViewThreeState extends State<HomeViewThree>
    with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
     BaseClient.box2.write("is_full_detail_completed",true);
    super.initState();
    tabController = TabController(
      initialIndex: widget.currentIndex == null ? 0 : widget.currentIndex!,
      length: 3,
      vsync: this,
    );
  }

  void onTapped(int i) {
    setState(() {
      widget.currentIndex = i;
    });
  }

  var children = [
    PageViewScreen(),
    // FindView(),
     PetTabbarScreen(),
    OwnerView(
      currentIndex: 0,
    )
  ];
  @override
  Widget build(BuildContext context) {
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
                    Image.asset("assets/Home/home1.png",
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
