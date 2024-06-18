import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petapp/app/component/no_found.dart';
import 'package:petapp/app/constent/api_urls.dart';
import 'package:petapp/app/model/all_co_owner_model.dart';
import 'package:petapp/app/model/common_error_model.dart';
import 'package:petapp/app/modules/find/views/find_view.dart';
import 'package:petapp/app/modules/find/views/volunter_screen.dart';
import 'package:petapp/app/modules/owner/views/add_co_owner_deatil.dart';

import 'package:petapp/app/modules/owner/views/first_owner_screen.dart';
import 'package:petapp/app/modules/owner/views/second_owner_screen.dart';

import '../../../../services/base_client.dart';
import '../../../constent/colors.dart';
import '../../../constent/textthem.dart';

class PetTabbarScreen extends StatefulWidget {
  int? currentIndex;
  PetTabbarScreen({Key? key, this.currentIndex}) : super(key: key);

  @override
  State<PetTabbarScreen> createState() => _PetTabbarScreenState();
}

class _PetTabbarScreenState extends State<PetTabbarScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      initialIndex: widget.currentIndex == null ? 0 : widget.currentIndex!,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  void onTapped(int i) {
    setState(() {
      widget.currentIndex = i;
    });
    print("current index   ${widget.currentIndex}");
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: TabBar(
              onTap: (index) {
                setState(() {
                  widget.currentIndex = index;
                });
                print("current index   ${widget.currentIndex}");
              },
              controller: tabController,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.red,
              indicatorColor: Colors.blue,
              indicatorWeight: 4,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
              labelPadding: EdgeInsets.zero,
              tabs: [
                Container(
                    margin: EdgeInsets.zero,
                    width: size.width * 0.5,
                    height: 40,
                    decoration: BoxDecoration(
                        color: widget.currentIndex == null ||
                                widget.currentIndex == 0
                            ? Color(0xff544099)
                            : Colors.white),
                    child: Center(
                      child: Text(
                        "Guardian",
                        style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 14,
                            color: widget.currentIndex == null ||
                                    widget.currentIndex == 0
                                ? Colors.white
                                : Colors.black),
                      ),
                    )),
                Container(
                    width: size.width * 0.5,
                    margin: EdgeInsets.zero,
                    height: 40,
                    decoration: BoxDecoration(
                        color: widget.currentIndex == 1
                            ? Color(0xff544099)
                            : Colors.white),
                    child: Center(
                      child: Text(
                        "Volunteer",
                        style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 14,
                            color: widget.currentIndex == 1
                                ? Color(0xfffffffff)
                                : Colors.black),
                      ),
                    ))
              ],
            )),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
        
          controller: tabController,
          children: <Widget>[FindView(), VounteerTabScreen()],
        ),
      ),
    );
  }
}
