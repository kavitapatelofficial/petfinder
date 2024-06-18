import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:petapp/app/constent/colors.dart';

import 'package:petapp/app/model/messge_model.dart';
import 'package:petapp/app/model/owner_coowner_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../services/base_client.dart';
import '../../../component/buttons/defaultbutton.dart';
import '../../../component/headings/my_column_text.dart';
import '../../../component/headings/my_headingtext.dart';
import '../../../component/textformfields/fixed_label_textformfiled.dart';
import '../../../constent/api_urls.dart';
import '../../../constent/static_images.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({Key? key}) : super(key: key);

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final TextEditingController phoneController = TextEditingController();
  var phone = "";

  final _formKey = GlobalKey<FormState>();
  BaseClient baseClient = BaseClient();
  OwnerAndCooownerModel? ownerAndCooownerModel;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Check for phone call support.
    canLaunchUrl(Uri(scheme: 'tel', path: '123')).then((bool result) {
      setState(() {});
    });
  }

  String result = "Hello World...!";
  Future _scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      if (!mounted) return;

      setState(() {
        result = qrCode;
        phoneController.text = result;

        getpetbyRfid();
      });
      print("QRCode_Result:--");
      print(qrCode);
    } on PlatformException {
      result = 'Failed to scan QR Code.';
    }

    print(
        "============resulut qr code==========$result=======================");
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  getpetbyRfid() async {
    var data = {};

    final apiResponse = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(baseClient.post(
        true,
        ConstantsUrls.baseURL,
        "${ConstantsUrls.getpetbyRfid}${phoneController.text}",
        data,
      )),
    );

    if (apiResponse != null) {
      var response = messageModelFromJson(apiResponse);
      ownerAndCooownerModel = ownerAndCooownerModelFromJson(apiResponse);

      if (response.success == false) {
        if (ownerAndCooownerModel!.owner != null) {
          Fluttertoast.showToast(
            msg: "${response.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );

          setState(() {});
        } else {
          phoneController.text = "";
          Fluttertoast.showToast(
            msg: "${response.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 5,
            backgroundColor: AppColor.neturalRed,
            textColor: Colors.white,
          );
        }

        // Get.offAll(LoginView());
      } else {
        ownerAndCooownerModel = ownerAndCooownerModelFromJson(apiResponse);

        Fluttertoast.showToast(
          msg: "${response.message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int currentPage = 0;
  final _pageController = PageController();

  void onAddButtonTapped(int index) {
    // use this to animate to the page

    // or this to jump to it without animating
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.accentWhite,
        body: SafeArea(
            child: ownerAndCooownerModel == null
                ? CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate([
                        Form(
                          key: _formKey,
                          child: Column(
                            // physics: NeverScrollableScrollPhysics(),
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Center(
                                  child: MyBodyHeadingText(text: "Find Pet")),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: MyBodyText(
                                    text:
                                        "Try to scan the implant in the right side of the  pet’s nect"),
                              ),
                              const SizedBox(
                                height: 37,
                              ),
                              Image.asset(
                                "assets/images/pet7.png",
                                height: 204,
                                width: 213,
                                // color: AppColor.accentLightGrey,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 53),
                                child: FixedLabelTextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: phoneController,
                                    hintText: '123-32xxx',
                                    labelText: 'RFID Number',
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return "RFID No. Required";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {
                                      // setState(() {
                                      //   // phone = value!.toString();
                                      // });
                                    },
                                    icon: InkWell(
                                        onTap: () {
                                          _scanQR(); //
                                        },
                                        child: Icon(
                                          Icons.qr_code,
                                          size: 22,
                                        ))),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 53),
                                  child: RoundedButton(
                                    text: "Submit",
                                    press: () {
                                      validRfid();
                                    },
                                  ))
                            ],
                          ),
                        ),
                      ]))
                    ],
                  )
                : CustomScrollView(
                    slivers: [
                      SliverList(
                          delegate: SliverChildListDelegate([
                        SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              ownerAndCooownerModel == null
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        const Center(
                                            child: MyBodyHeadingText(
                                                text: "Call the Owner")),
                                        const Center(
                                            child: MyBodyText(
                                                text: "Dog Identified")),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              // color: AppColor.neturalBrown,
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              height: 100,
                                              width: 100,
                                            ),
                                            Image.asset(
                                              Constants.CIRCLE,
                                              height: 100,
                                              width: 100,
                                              color: HexColor("#F1F1F1"),
                                            ),
                                            Positioned.fill(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  "assets/Home/footprint.png",
                                                  color: AppColor.neturalGreen,
                                                  height: 48,
                                                  width: 48,
                                                ),
                                              ),
                                            ),
                                            Positioned.fill(
                                              top: 20,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Image.asset(
                                                  "assets/Home/check.png",
                                                  color: AppColor.accentWhite,
                                                  height: 11,
                                                  width: 11,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ColumnText(
                                            text1: "Owner",
                                            text2: ownerAndCooownerModel!
                                                    .owner!.name ??
                                                ""),
                                        ColumnText(
                                            text1: "Pet Details",
                                            text2: ownerAndCooownerModel!
                                                    .owner!.name ??
                                                ""),
                                        ColumnText(
                                            text1: "Phone Number",
                                            text2:
                                                "${ownerAndCooownerModel!.owner!.phoneNumber ?? ""}"),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 53),
                                            child: RoundedButton(
                                              text: "Call",
                                              press: () {
                                                _makePhoneCall(
                                                    "${ownerAndCooownerModel!.owner!.phoneNumber ?? ""}");
                                                // onAddButtonTapped(2);
                                              },
                                            )),
                                      ],
                                    )
                            ],
                          ),
                        )
                      ])),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        SingleChildScrollView(
                          // physics: NeverScrollableScrollPhysics(),
                          child: ListView.builder(
                              itemCount: ownerAndCooownerModel!.coOwner!.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return ownerAndCooownerModel == null
                                    ? const SizedBox()
                                    : Column(
                                        children: [
                                          const Center(
                                              child: MyBodyHeadingText(
                                                  text: "Call the Co-Owner")),
                                          const MyBodyText(
                                              text: "Dog Identified"),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                // color: AppColor.neturalBrown,
                                                padding: const EdgeInsets.only(
                                                    right: 20),
                                                height: 100,
                                                width: 100,
                                              ),
                                              Image.asset(
                                                Constants.CIRCLE,
                                                height: 100,
                                                width: 100,
                                                color: HexColor("#F1F1F1"),
                                              ),
                                              Positioned.fill(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                    "assets/Home/footprint.png",
                                                    color:
                                                        AppColor.neturalGreen,
                                                    height: 48,
                                                    width: 48,
                                                  ),
                                                ),
                                              ),
                                              Positioned.fill(
                                                top: 20,
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Image.asset(
                                                    "assets/Home/check.png",
                                                    color: AppColor.accentWhite,
                                                    height: 11,
                                                    width: 11,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ColumnText(
                                              text1: "Owner",
                                              text2: ownerAndCooownerModel!
                                                      .coOwner![index].name ??
                                                  ""),
                                          ColumnText(
                                              text1: "Pet Details",
                                              text2: ownerAndCooownerModel!
                                                      .coOwner!.first.name ??
                                                  ""),
                                          ColumnText(
                                              text1: "Phone Number",
                                              text2:
                                                  "${ownerAndCooownerModel!.coOwner![index].phone ?? ""}"),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 53),
                                              child: RoundedButton(
                                                text: "Call",
                                                press: () {
                                                  _makePhoneCall(
                                                      "${ownerAndCooownerModel!.coOwner![index].phone ?? ""}");
                                                },
                                              )),
                                        ],
                                      );
                              }),
                        )
                      ])),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        SizedBox(
                          height: 20,
                        )
                      ]))
                    ],
                  )));
  }

  validRfid() {
    var valid = _formKey.currentState!.validate();
    if (valid) {
      getpetbyRfid();
    } else {
      return;
    }
  }
}
