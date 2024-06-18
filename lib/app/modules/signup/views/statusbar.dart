import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petapp/app/constent/colors.dart';

class StatusBar extends StatelessWidget {
  final String status;

  const StatusBar({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return status == "1"
        ? status1()
        : status == "2"
            ? status2()
            : status == "3"
                ? status3()
                : status4();
  }

  Row status1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _circle1(),
        _halfline(),
        _circle2(),
        _dottedline(),
        _circle2(),
        // _dottedline(),
        // _circle2(),
      ],
    );
  }

  Row status2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _circle3(),
        _fulline(),
        _circle1(),
        _halfline(),
        _circle2(),
        // _dottedline(),
        // _circle2(),
      ],
    );
  }

  Row status3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _circle3(),
        _fulline(),
        _circle3(),
        _fulline(),
        _circle1(),
        // _halfline(),
        // _circle2(),
      ],
    );
  }

  Row status4() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _circle3(),
        _fulline(),
        _circle3(),
        _fulline(),
        _circle3(),
        // _fulline(),
        // _circle1(),
      ],
    );
  }

  Container _halfline() {
    return Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        width: 61,
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                width: 20,
                height: 2,
                color: AppColor.primaryColor),
            Expanded(
                child: DottedLine(
              dashColor: HexColor("#9DCAFF"),
              lineThickness: 2,
            ))
          ],
        ));
  }

  Container _fulline() {
    return Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        width: 61,
        height: 2,
        color: AppColor.primaryColor);
  }

  SizedBox _dottedline() {
    return SizedBox(
      width: 61,
      child: DottedLine(
        dashColor: HexColor("#9DCAFF"),
        lineThickness: 2,
      ),
    );
  }

  CircleAvatar _circle3() {
    return CircleAvatar(
      radius: 10,
      backgroundColor: AppColor.primaryColor,
    );
  }

  CircleAvatar _circle2() {
    return CircleAvatar(
      radius: 10,
      backgroundColor: HexColor("#9DCAFF"),
    );
  }

  Container _circle1() {
    return Container(
      padding: const EdgeInsets.all(3),
      height: 27,
      width: 27,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColor.primaryColor)),
      child: CircleAvatar(
        radius: 11,
        backgroundColor: AppColor.lightblue,
      ),
    );
  }
}
