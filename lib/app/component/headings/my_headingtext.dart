import 'package:flutter/material.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/textthem.dart';

class MyHeadingText extends StatelessWidget {
  final String text;
  const MyHeadingText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: Center(
        child: Text(text,
          textAlign: TextAlign.center,
        style: Texttheme.heading1.copyWith(color: AppColor.primaryColor,),),
      ),
    );
  }
}

class MyHeadingTwoText extends StatelessWidget {
  final String text;
  const MyHeadingTwoText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
     
      height: 22,
      child: Center(
        child: Text(text,
          textAlign: TextAlign.center,
        style: Texttheme.heading2),
      ),
    );
  }
}

class MyBodyHeadingText extends StatelessWidget {
  final String text;
  const MyBodyHeadingText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
      
        height: 33,
        child: Text(text,
          textAlign: TextAlign.left,
        style: Texttheme.subheading.copyWith(color: AppColor.primaryColor,),)
      ),
    );
  }
}

class MyBodyText extends StatelessWidget {
  final String text;
  const MyBodyText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 311,
      height: 38,
      child: Center(
        child: Text(
          text,
          
          textAlign: TextAlign.center,
          style: 
          
          Texttheme.bodyText1,),
      ),
    );
  }
}