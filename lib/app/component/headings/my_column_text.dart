import 'package:flutter/material.dart';

import '../../constent/textthem.dart';

class ColumnText extends StatelessWidget {
  final String text1;
  final String text2;
  const ColumnText({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 47),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text2,
              style: Texttheme.subTitle,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(text1, style: Texttheme.title),
            const SizedBox(
              height: 16,
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
