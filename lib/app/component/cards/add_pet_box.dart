import 'package:flutter/material.dart';
import 'package:petapp/app/constent/api_urls.dart';

import '../../constent/colors.dart';

class AddPet extends StatelessWidget {
  final String image;
  const AddPet({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      height: 56,
      width: 63,
      decoration: BoxDecoration(
          color: AppColor.accentWhite,
          borderRadius: BorderRadius.circular(10), //border corner radius
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), //color of shadow
              spreadRadius: 1, //spread radius
              blurRadius: 1, // blur radius
              offset: const Offset(0, 0.2), // changes position of shadow
              //first paramerter of offset is left-right
              //second parameter is top to down
            ),
            //you can set more BoxShadow() here
          ],
          image:
              DecorationImage(
              
                onError: (exception, stackTrace) => const Icon(Icons.error),
                fit: BoxFit.cover, image: NetworkImage("${ConstantsUrls.baseURL}/api/$image"))),
    );
  }
}
