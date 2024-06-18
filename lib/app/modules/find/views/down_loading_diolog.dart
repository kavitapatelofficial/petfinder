// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:petapp/app/constent/api_urls.dart';
import 'package:petapp/app/constent/colors.dart';

class DownloadingDialog extends StatefulWidget {
  final String file1;
  const DownloadingDialog({Key? key, required this.file1}) : super(key: key);

  @override
  _DownloadingDialogState createState() => _DownloadingDialogState();
}

class _DownloadingDialogState extends State<DownloadingDialog> {
  final Dio dio = Dio();
  bool loading = false;
  double progress = 0;

  Future<bool> saveVideo(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        String url = ConstantsUrls.baseURL + "/api/" + "${widget.file1}";

        String fileName = "RFID_Certificate.png";

        String path = await _getFilePath(fileName);

        print("==========path==$path====");

        await dio.download(
          url,
          path,
          onReceiveProgress: (recivedBytes, totalBytes) {
            setState(() {
              progress = recivedBytes / totalBytes;
            });
          },
          deleteOnError: true,
        ).then((_) async {
          final baseStorage = await getExternalStorageDirectory();
          final taskId = await FlutterDownloader.enqueue(
            url: url,
            headers: {},
            fileName:
                "RFIDCertificate", // optional: header send with url (auth token etc)
            savedDir: baseStorage!.path,
            showNotification:
                true, // show download progress in status bar (for Android)
            openFileFromNotification:
                true, // click on notification to open downloaded file (for Android)
          );
        });
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String> _getFilePath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return "${dir.path}/$filename";
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  downloadFile() async {
    setState(() {
      loading = true;
      progress = 0;
    });
    bool downloaded =
        await saveVideo("${ConstantsUrls.baseURL}/api/${widget.file1}", "");
    if (downloaded) {
      print("File Downloaded==$downloaded");
    } else {
      print("Problem Downloading File");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String downloadingprogress = (progress * 100).toInt().toString();

    return AlertDialog(
      backgroundColor: Colors.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // const CircularProgressIndicator.adaptive(),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: loading
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator.adaptive(),
                  )
                : TextButton.icon(
                    icon: Icon(
                      Icons.download_rounded,
                      color: Colors.white,
                    ),
                    // color: Colors.blue,
                    onPressed: () async {
                      String url =
                          ConstantsUrls.baseURL + "/api/" + "${widget.file1}";

                      Map<Permission, PermissionStatus> statuses = await [
                        Permission.storage,
                        //add more permission to request here.
                      ].request();

                      if (statuses[Permission.storage]!.isGranted) {
                        var dir =
                            await DownloadsPathProvider.downloadsDirectory;
                        if (dir != null) {
                          String savename = "/Rfid_certificate.png";
                          String savePath = dir.path + "$savename";
                          print(savePath);
                          //output:  /storage/emulated/0/Download/banner.png

                          try {
                            setState(() {
                              loading = true;
                              progress = 0;
                            });
                            await Dio().download(url, savePath,
                                onReceiveProgress: (received, total) {
                              if (total != -1) {
                                print((received / total * 100)
                                        .toStringAsFixed(0) +
                                    "%");
                                //you can build progressbar feature too
                              }
                            });
                            setState(() {
                              loading = false;
                            });
                            print("File is saved to download folder.");
                            Fluttertoast.showToast(
                              msg:
                                  "RFID Certificate  is saved to download folder.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: AppColor.neturalGreen,
                              textColor: Colors.white,
                            );
                            Navigator.of(context).pop();
                          } on DioError catch (e) {
                            setState(() {
                              loading = false;
                            });
                            Fluttertoast.showToast(
                              msg: "${e.message}",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 5,
                              backgroundColor: AppColor.neturalRed,
                              textColor: Colors.white,
                            );
                            Navigator.of(context).pop();
                            print(e.message);
                          }
                        }
                      } else {
                        setState(() {
                          loading = false;
                        });
                        Fluttertoast.showToast(
                          msg: "No permission to read and write.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: AppColor.neturalRed,
                          textColor: Colors.white,
                        );
                        Navigator.of(context).pop();
                        print("No permission to read and write.");
                      }
                    },
                    // padding: const EdgeInsets.all(10),
                    label: Text(
                      "Download File",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
          )
        ],
      ),
    );
  }
}
