import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:petapp/app/constent/api_urls.dart';

class FilePreview extends StatefulWidget {
  final String file;
  _FilePreviewState createState() => _FilePreviewState();

  FilePreview({required this.file});
}

class _FilePreviewState extends State<FilePreview> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 60,
              ),
              widget.file == null
                  ? SizedBox()
                  : Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(ConstantsUrls.baseURL +
                                  "/api/" +
                                  widget.file))),
                    ),
              SizedBox(
                height: 60,
              ),
              Text("${widget.file}"),
            ],
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.topRight,
            child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.close,
                  size: 33,
                )),
          ))
        ],
      ),
    );
  }
}
