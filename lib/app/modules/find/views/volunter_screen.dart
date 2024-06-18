// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:petapp/app/component/cards/add_pet_box.dart';
import 'package:petapp/app/component/file_preview.dart';

import 'package:petapp/app/component/no_found.dart';

import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/textthem.dart';
import 'package:petapp/app/model/all_pet_model.dart';
import 'package:petapp/app/model/all_vaccine_model.dart';
import 'package:petapp/app/modules/find/views/down_loading_diolog.dart';
import 'package:petapp/app/modules/find/views/first_pet_screen.dart';
import 'package:petapp/app/modules/pet_detail/views/add_pet_detail.dart';

import 'package:petapp/app/modules/pet_detail/views/pet_detail_view.dart';

import '../../../../services/base_client.dart';
import '../../../component/buttons/defaultbutton.dart';
import '../../../component/buttons/upload_chip_button.dart';
import '../../../component/cards/vacination_trackercard.dart';
import '../../../component/dialog_box/show_dialogs.dart';
import '../../../component/headings/my_headingtext.dart';
import '../../../component/textformfields/my_textform_field.dart';
import '../../../component/textformfields/textform_field_icon.dart';
import '../../../model/createpet_response.dart';
import 'package:petapp/app/constent/api_urls.dart';
import 'package:http/http.dart' as http;

class VounteerTabScreen extends StatefulWidget {
  const VounteerTabScreen({Key? key}) : super(key: key);

  @override
  State<VounteerTabScreen> createState() => _VounteerTabScreenState();
}

class _VounteerTabScreenState extends State<VounteerTabScreen> {
  AllPetModel? allPetModel;
  bool showCerti = false;
  bool showTextnot = false;
  bool isLoading = true;
   final ImagePicker _picker = ImagePicker();
  late ValueNotifier<bool> isVLoading = ValueNotifier(false);
  late ValueNotifier<String> listenToThisValue = ValueNotifier('xyz');
  BaseClient baseClient = BaseClient();
  final TextEditingController vaccineNameController = TextEditingController();
  final TextEditingController vaccineDateController = TextEditingController();
  final TextEditingController doseController = TextEditingController();
  final TextEditingController uploadNameController = TextEditingController();
  final _uploadCertiformKey = GlobalKey<FormState>();

  // String? idCertifiacat;
  File? uploadCertifiacate;

  String? selectedValue4;

  List<DropdownMenuItem<String>> get dropdownItems4 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text("7-1 or similar"), value: "7-1 or similar"),
    ];
    return menuItems;
  }

  remove_Certificate(
    String petID,
    String vaccineID,
  ) async {
    try {
      var headers = {
        'Authorization': 'Bearer ${BaseClient.box2.read("logintoken")}',
        'Content-Type': 'application/json'
      };

      print("===========headers=====$headers==============");

      var data = {
        'petId': petID,
        'vaccineId': vaccineID,
        'vaccineDose': doseController.text,
        'vaccineDate': null
      };

      print("===========data=====$data==============");

      print(ConstantsUrls.baseURL + ConstantsUrls.updateVaccine);
      var request = http.MultipartRequest('PUT',
          Uri.parse(ConstantsUrls.baseURL + ConstantsUrls.updateVaccine));
      request.fields.addAll({
        'petId': petID,
        'vaccineId': vaccineID,
        'vaccineDose': 0.toString(),
        'vaccineDate': null.toString()
      });

      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      print("==========response=====${response.statusCode}==============");

      if (response.statusCode == 200) {
        doseController.text = "";
        vaccineDateController.text = "";
        uploadCertifiacate = null;
        var data1 = await response.stream.bytesToString();
        // var data = createPetModelFromJson(data1);
        // BaseClient.box2.write("pet_id", data.pet!.id);
        // BaseClient.box2.write("pet_image", data.rfidImage);
        // BaseClient.box2.write("pet_rfidImage", data.rfidImage);
        // print(await response.stream.bytesToString());

        Fluttertoast.showToast(
          msg: "Removed certificate successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 5,
          backgroundColor: AppColor.neturalGreen,
          textColor: Colors.white,
        );
        // Get.to(SignupViewTwo());;
        getallpet2();

        // Navigator.of(context).pop();
      } else {}
    } finally {}
  }

  upload_Certificate(
    String petID,
    String vaccineID,
  ) async {
     setState(() {
            isVLoading.value = true;
          });
    try {
      var headers = {
        'Authorization': 'Bearer ${BaseClient.box2.read("logintoken")}',
        'Content-Type': 'application/json'
      };

      print("===========headers=====$headers==============");

      var data = {
        'petId': petID,
        'vaccineId': vaccineID,
        'vaccineDose': doseController.text,
        'vaccineDate': vaccineDateController.text
      };

      print("===========data=====$data==============");

      print(ConstantsUrls.baseURL + ConstantsUrls.updateVaccine);
      var request = http.MultipartRequest('PUT',
          Uri.parse(ConstantsUrls.baseURL + ConstantsUrls.updateVaccine));
      request.fields.addAll({
        'petId': petID,
        'vaccineId': vaccineID,
        'vaccineDose': doseController.text,
        'vaccineDate': vaccineDateController.text
      });

      if (uploadCertifiacate != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'certificate', uploadCertifiacate!.path));
      }
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      print("==========response=====${response.statusCode}==============");

      if (response.statusCode == 200) {
        doseController.text = "";
        vaccineDateController.text = "";
        uploadCertifiacate = null;
        var data1 = await response.stream.bytesToString();
        var data2 = jsonDecode(data1);

        print("=====data1=============$data1===============");
        // var data = createPetModelFromJson(data1);
        // BaseClient.box2.write("pet_id", data.pet!.id);

        // BaseClient.box2.write("pet_image", data.pet!.rfidNo);
        // BaseClient.box2.write("pet_rfidImage", data.pet!.rfidNo);
        // print(await response.stream.bytesToString());
        if (data2['success'] == true) {
          setState(() {
            isVLoading.value = false;
          });

          Fluttertoast.showToast(
            msg: "${data2['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: AppColor.neturalGreen,
            textColor: Colors.white,
          );
          getallpet2();
          Get.back();
        } else {
          setState(() {
            isVLoading.value = false;
          });
          Fluttertoast.showToast(
            msg: "${data2['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: AppColor.neturalRed,
            textColor: Colors.white,
          );
        }
        getallpet2();
        Get.back();
        // Get.to(SignupViewTwo());;

        // Navigator.of(context).pop();
      } else {}
    } finally {}
  }

  getallpet() async {
    isLoading = true;
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "${ConstantsUrls.GetAllPetByVolunteer}${BaseClient.box2.read("user_id")}");
    if (response != null) {
      allPetModel = allPetModelFromJson(response);
    }
    isLoading = false;
    setState(() {});
  }

  getallpet2() async {
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "${ConstantsUrls.GetAllPetByVolunteer}${BaseClient.box2.read("user_id")}");
    if (response != null) {
      allPetModel = allPetModelFromJson(response);
    }

    setState(() {});
  }

  AllVaccineModel? _allVaccineModel;
  bool isVaccineLoading = true;

  getVaccine() async {
    isVaccineLoading = true;
    var response = await baseClient.get(
        false, ConstantsUrls.baseURL, "${ConstantsUrls.GetAllVaccine}");
    _allVaccineModel = allVaccineModelFromJson(response);
    isVaccineLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getallpet();
    getVaccine();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  _getdocuments() async {
    // FilePickerResult? result =
    //     await FilePicker.platform.pickFiles(allowCompression: true);
    var result = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 30,);

    if (result != null) {
      var file = File(result.path);
      setState(() {
        uploadCertifiacate = file;
        uploadNameController.text = uploadCertifiacate!.path.split("/").last;
         listenToThisValue.value = uploadNameController.text;
      });

      // Navigator.of(context).pop();
    } else {
      // User canceled the picker
    }
  }

  final TextEditingController noteController = TextEditingController();

  bool isWnLoading = true;

  writeNote(String petid) async {
    var data = {"note": noteController.text};

    final apiResponse = await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(baseClient.put(
        false,
        ConstantsUrls.baseURL,
        ConstantsUrls.writeNote + petid,
        data,
      )),
    );

    if (apiResponse != null) {
      Fluttertoast.showToast(
        msg: "Your note successfuly submitted",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColor.neturalGreen,
        textColor: Colors.white,
      );
      getallpet2();
    } else {
      Fluttertoast.showToast(
        msg: "Something Wrong please try again..",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  SliverAppBar showSliverAppBar() {
    return SliverAppBar(
      backgroundColor: AppColor.accentWhite,
      elevation: 0,
      expandedHeight: 50.0,
      floating: false,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: BaseClient.box2.read("userLogin") == false ? 0 : 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BaseClient.box2.read("userLogin") == false
                  ? SizedBox()
                  : SizedBox(
                      width: 0,
                    ),
              BaseClient.box2.read("userLogin") == false
                  ? SizedBox(
                      width: 0,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            // Get.to(PetDetailView());
                            Get.to(const AddPetDetailScreen());
                          },
                          child: Container(
                            height: 55,
                            width: 57,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              color: AppColor.accentLightGrey,
                              borderRadius: BorderRadius.circular(
                                  10), //border corner radius
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), //color of shadow
                                  spreadRadius: 1, //spread radius
                                  blurRadius: 1, // blur radius
                                  offset: const Offset(
                                      0, 0.2), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                ),
                                //you can set more BoxShadow() here
                              ],
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.black,
                                size: 40,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          "Add",
                          style: Texttheme.title,
                        ),
                        const SizedBox(
                          height: 3.5,
                        ),
                      ],
                    ),
              const SizedBox(
                width: 10,
              ),
              isLoading
                  ? const SizedBox()
                  : allPetModel!.success == false
                      ? SizedBox()
                      : Expanded(
                          child: TabBar(
                              padding: EdgeInsets.zero,
                              indicatorColor: AppColor.primaryColor,
                              isScrollable: true,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicatorPadding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              labelColor: Colors.black,
                              labelStyle:
                                  Texttheme.title.copyWith(color: Colors.black),
                              tabs: allPetModel!.result!.isEmpty
                                  ? []
                                  : allPetModel!.result!.map((e) {
                                      return Tab(
                                        iconMargin:
                                            const EdgeInsets.only(bottom: 10),
                                        height: 100,
                                        icon: AddPet(image: "${e.photo}"),
                                        text: '${e.name}',
                                      );
                                    }).toList()),
                        ),
              BaseClient.box2.read("userLogin") == false
                  ? SizedBox()
                  : const SizedBox(
                      width: 0,
                    )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : allPetModel!.success == false
            ? Scaffold(
                backgroundColor: AppColor.accentWhite,
                body: CustomScrollView(
                  slivers: [
                    showSliverAppBar(),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (_, int index) {
                          return noFound("No Pet Found", null);
                        },
                        childCount: 1,
                      ),
                    ),
                  ],
                ),
              )
            : DefaultTabController(
                length: allPetModel!.result!.isEmpty
                    ? 0
                    : allPetModel!.result!.length,
                child: Scaffold(
                  body: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          showSliverAppBar(),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (_, int index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [],
                                );
                              },
                              childCount: 1,
                            ),
                          ),
                        ];
                      },
                      body: TabBarView(
                        children: allPetModel!.result!.isEmpty
                            ? []
                            : allPetModel!.result!.map((e) {
                                // noteController.text = e.note==null?"":e.note
                                return CustomScrollView(
                                  slivers: [
                                    SliverList(
                                      delegate: SliverChildListDelegate([
                                        Column(
                                          children: [
                                            FirstPetScreen(
                                              hintText: e.note == null
                                                  ? "Write a note about your dog"
                                                  : e.note!,
                                              image: e.photo == null
                                                  ? ""
                                                  : e.photo!,
                                              name:
                                                  e.name == null ? "" : e.name!,
                                              breed: e.breed == null
                                                  ? ""
                                                  : e.breed!,
                                              year: e.age ?? "",
                                              gender: e.gender == null
                                                  ? ""
                                                  : e.gender!,
                                              rfidNo: e.gender == null
                                                  ? ""
                                                  : e.rfidNo.toString(),
                                              onUpadate: () {
                                                Get.to(PetDetailView(
                                                  petId: e.id.toString(),
                                                ));
                                              },
                                              onDownload: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      DownloadingDialog(
                                                          file1: e.rfidImage
                                                              .toString()),
                                                );
                                              },
                                              onReview: (value) {
                                                if (noteController
                                                    .text.isNotEmpty) {
                                                  writeNote(e.id.toString());
                                                } else {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        "Please write something about pet",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.SNACKBAR,
                                                    timeInSecForIosWeb: 2,
                                                    backgroundColor:
                                                        Colors.green,
                                                    textColor: Colors.white,
                                                  );
                                                }
                                                return null;
                                              },
                                              writeNoteController:
                                                  noteController,
                                              petid2: e.id == null ? "" : e.id!,
                                              allPetModel: allPetModel!,
                                              isUploadCerti: '',
                                              onUploadCertifiacte: () {},
                                              vaccineDate: '',
                                              vaccineListCount: 3,
                                              vaccineName: '',
                                            ),
                                            // Text("${e.vaccine==null?null:e.vaccine!.length}"),
                                            e.vaccine == null
                                                ? const SizedBox()
                                                : Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 30,
                                                        vertical: 10),
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColor.accentWhite,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10), //border corner radius
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.5), //color of shadow
                                                          spreadRadius:
                                                              5, //spread radius
                                                          blurRadius:
                                                              7, // blur radius
                                                          offset: const Offset(
                                                              0,
                                                              2), // changes position of shadow
                                                          //first paramerter of offset is left-right
                                                          //second parameter is top to down
                                                        ),
                                                        //you can set more BoxShadow() here
                                                      ],
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const MyBodyHeadingText(
                                                                text:
                                                                    "Vaccine Tracker"),
                                                            TextButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    showCerti =
                                                                        !showCerti;
                                                                  });
                                                                },
                                                                child: Text(
                                                                  "${showCerti ? "Done" : "Edit"}",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xff544099),
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400),
                                                                ))
                                                          ],
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom: 16),
                                                          child: Divider(
                                                            height: 2,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        Column(
                                                            // children:e.vaccine.,
                                                            children: e.vaccine!
                                                                .map((vaccine) {
                                                          return Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    // ignore: prefer_const_literals_to_create_immutables
                                                                    children: [
                                                                      VacinationTrackerCard(
                                                                          shownotCompleted: vaccine.certificate == "" || vaccine.certificate == null
                                                                              ? false
                                                                              : true,
                                                                          showCertficatdOrNot:
                                                                              showCerti,
                                                                          onShow:
                                                                              () {
                                                                            print("=====vaccine.certificate!=====${vaccine.certificate!}=========");

                                                                            vaccine.certificate == "" || vaccine.certificate == null
                                                                                ? null
                                                                                : Get.to(FilePreview(
                                                                                    file: vaccine.certificate!,
                                                                                  ));
                                                                          },
                                                                          onPress:
                                                                              () {
                                                                            vaccine.certificate == "" || vaccine.certificate == null
                                                                                ? _uploadCertificate(context, e.id!, vaccine.id.toString())
                                                                                : remove_Certificate(e.id!, vaccine.id.toString());
                                                                          },
                                                                          showPreview: vaccine.certificate == "" || vaccine.certificate == null
                                                                              ? false
                                                                              : true,
                                                                          titletext: vaccine.name ??
                                                                              "",
                                                                          buttontext:
                                                                              "${vaccine.certificate == "" || vaccine.certificate == null ? "Add Certificate" : "Remove Certificate"}",
                                                                          date:
                                                                              "${vaccine.certificate == "" || vaccine.certificate == null ? "NA" : vaccine.date.toString().characters.take(10)} ",
                                                                          icon1: vaccine.certificate == "" || vaccine.certificate == null
                                                                              ? "assets/Home/Download_up.png"
                                                                              : "assets/images/icon22.png",
                                                                          icon2:
                                                                              "assets/Home/folder1.png"),
                                                                      const Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(vertical: 16),
                                                                        child:
                                                                            Divider(
                                                                          height:
                                                                              2,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        height:
                                                                            20,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          );
                                                        }).toList()),
                                                      ],
                                                    ),
                                                  )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Stack(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    onAlertButtonsPressed(
                                                        context,
                                                        e.id ?? "",
                                                        e.name ?? "");
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      left: 20,
                                                      right: 10,
                                                    ),
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    height: 50,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        color: AppColor
                                                            .accentLightGrey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: Center(
                                                      child: Text(
                                                        "Lost My Pet",
                                                        style: Texttheme.title,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                    top: 6,
                                                    left: 6,
                                                    child: Row(
                                                      children: [
                                                        Image.asset(
                                                          "assets/Home/footprint.png",
                                                          color: AppColor
                                                              .neturalYellow,
                                                          height: 30,
                                                          width: 30,
                                                        ),
                                                        const SizedBox(
                                                          width: 30,
                                                        )
                                                      ],
                                                    ))
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 100,
                                        )
                                      ]),
                                    ),
                                  ],
                                );
                              }).toList(),
                      )),
                ),
              );
  }

  void _uploadCertificate(
    context,
    String petId,
    String vaccineID1,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext bc) {
        return StatefulBuilder(builder: (context, state) {
          return ValueListenableBuilder(
              valueListenable: listenToThisValue,
              builder: (context, indicatorEnabled, child) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Form(
                      key: _uploadCertiformKey,
                      child: Wrap(
                        children: <Widget>[
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            child: UploadChipButton(
                              press: () {
                                _getdocuments();
                              },
                              text: "Upload vaccination Certificate",
                              showicon: true,
                            ),
                          ),
                          uploadNameController.text.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Center(
                                    child: Text(
                                      uploadNameController.text,
                                      style: Texttheme.title
                                          .copyWith(color: Colors.blue),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 60,
                          ),
                          DropdownButtonFormField2(
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xffE5E4F2),
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xffE5E4F2),
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xffE5E4F2),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xffE5E4F2),
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              //Add isDense true and zero Padding.
                              //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                              isDense: true,
                              contentPadding: EdgeInsets.zero,

                              //Add more decoration as you want here
                              //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                            ),
                            isExpanded: true,
                            hint: const Text(
                              '7-1 or Similar',
                              style: TextStyle(fontSize: 14),
                            ),
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black45,
                            ),
                            iconSize: 30,
                            buttonHeight: 50,
                            dropdownDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            items: _allVaccineModel!.vaccine!.map((e) {
                              return DropdownMenuItem(
                                  child: Text("${e!.name}"),
                                  value: "${e.name}");
                            }).toList(),
                            value: selectedValue4,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select dose';
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedValue4 = value.toString();
                                doseController.text = selectedValue4!;
                              });

                              //Do something when changing the item if you want.
                            },
                            onSaved: (value) {
                              setState(() {
                                selectedValue4 = value.toString();
                                doseController.text = selectedValue4!;
                              });
                            },
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          TextFormFieldIcon(
                            read: true,
                            ontab: () async {
                              var date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now());
                              vaccineDateController.text =
                                  date.toString().substring(0, 10);
                            },
                            hintText: 'Vaccination Date',
                            // prefixIcon: Icons.email,
                            icon: GestureDetector(
                                onTap: () async {
                                  var date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now());
                                  vaccineDateController.text =
                                      date.toString().substring(0, 10);
                                },
                                child: const Icon(Icons.calendar_month)),
                            controller: vaccineDateController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Vaccination Date required";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          isVLoading.value == true
                              ? Container(
                                  height: 60,
                                  width: double.infinity,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ))
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 53),
                                  child: RoundedButton(
                                    text: "Upload",
                                    press: () {
                                      // print(
                                      // "=====phone====$phone======${phoneController.text.length == 10}========");

                                      if (uploadCertifiacate != null) {
                                        setState(() {
                                          isVLoading.value = true;
                                        });
                                        upload_Certificate(petId, vaccineID1);
                                      } else {
                                        Fluttertoast.showToast(
                                          msg:
                                              "Please upload vaccination certificate",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 2,
                                          backgroundColor: AppColor.neturalRed,
                                          textColor: Colors.white,
                                        );
                                        return null;
                                      }
                                    },
                                  )),
                        ],
                      ),
                    ),
                  ),
                );
              });
        });
      },
    );
  }
}
