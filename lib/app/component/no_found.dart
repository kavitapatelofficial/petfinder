import 'package:flutter/cupertino.dart';
import 'package:petapp/app/constent/colors.dart';

import '../constent/static_images.dart';

Container noFound(String text,IconData? image) {
  return Container(
    height: 400,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        image==null?
        Image.asset(Constants.No_FOUND,height: 100,):Icon(image,color: AppColor.neturalRed,size: 55,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ],
    ),
  );
}
