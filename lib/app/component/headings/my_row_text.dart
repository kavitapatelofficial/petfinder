import 'package:flutter/material.dart';

import '../../constent/textthem.dart';

class RowText extends StatelessWidget {
  final String text1;
  final String text2;
  const RowText({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: Text(text1, style: Texttheme.title)),
         
          Expanded(
            child: SizedBox(
              width: 200,
              
              child: Text(text2, style: Texttheme.subTitle,
              maxLines: 4,
          
              overflow: TextOverflow.ellipsis,
              )),
          ),
        ],
      ),
    );
  }
}
