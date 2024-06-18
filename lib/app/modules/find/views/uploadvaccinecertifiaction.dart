import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petapp/app/component/buttons/defaultbutton.dart';
import 'package:petapp/app/component/buttons/upload_chip_button.dart';
import 'package:petapp/app/component/textformfields/textform_field_icon.dart';
import 'package:petapp/app/constent/api_urls.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/constent/textthem.dart';
import 'package:petapp/app/model/all_vaccine_model.dart';
import 'package:petapp/app/modules/home/views/home_view.dart';
import 'package:petapp/app/modules/home/views/home_view2.dart';
import 'package:petapp/services/base_client.dart';
import 'package:http/http.dart' as http;

class UploadVaccineCertifaication extends StatefulWidget {
  final String petId;
  final String petName;
  final String vaccineID;
  const UploadVaccineCertifaication(
      {super.key,
      required this.petId,
      required this.vaccineID,
      required this.petName});

  @override
  State<UploadVaccineCertifaication> createState() =>
      _UploadVaccineCertifaicationState();
}

class _UploadVaccineCertifaicationState
    extends State<UploadVaccineCertifaication> {
  bool showCerti = false;
   final ImagePicker _picker = ImagePicker();
  bool showTextnot = false;
  bool isLoading = false;
  File? uploadCertifiacate;
  BaseClient baseClient = BaseClient();
  final TextEditingController vaccineNameController = TextEditingController();
  final TextEditingController vaccineDateController = TextEditingController();
  final TextEditingController doseController = TextEditingController();
  final TextEditingController uploadNameController = TextEditingController();
  final _uploadCertiformKey = GlobalKey<FormState>();

  AllVaccineModel? _allVaccineModel;
  bool isVaccineLoading = true;

  String? selectedValue4;

  getVaccine() async {
    setState(() {
      isVaccineLoading = true;
    });

    var response = await baseClient.get(
        false, ConstantsUrls.baseURL, "${ConstantsUrls.GetAllVaccine}");
    _allVaccineModel = allVaccineModelFromJson(response);
    isVaccineLoading = false;
    setState(() {});
  }

  _getdocuments() async {
    var result = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 30,);

    if (result != null) {
      var file = File(result.path);
      setState(() {
        uploadCertifiacate = file;
        uploadNameController.text = uploadCertifiacate!.path.split("/").last;
      });
      setState(() {});

      // Navigator.of(context).pop();
    } else {
      // User canceled the picker
    }
  }

  upload_Certificate(
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
            bool isLoading = false;
          });

          Fluttertoast.showToast(
            msg: "${data2['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 5,
            backgroundColor: AppColor.neturalGreen,
            textColor: Colors.white,




          );

           Get.offAll(HomeViewTwo(
            currentIndex: 1,
          ));
        } else {
          setState(() {
            bool isLoading = false;
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
        // Get.to(SignupViewTwo());;

        // Navigator.of(context).pop();
      } else {
         setState(() {
        bool isLoading = false;
      });
      }
    } finally {
      setState(() {
        bool isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getVaccine();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: BackButton(
            onPressed: (){
               Get.offAll(HomeView(
            currentIndex: 1,
          ));
            },
            color: Colors.black,
          ),
          backgroundColor: AppColor.accentWhite,
          elevation: 0,
          title: Text(
            "Complete Vaccination detail",
            style: TextStyle(color: Colors.black, fontSize: 15),
          )),
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
              child: Text(
            "${widget.petName}",
            style: Texttheme.subheading,
          )),
          isVaccineLoading
              ? SizedBox(
                height: 400,
                width: double.infinity,
                child: Center(child:CircularProgressIndicator()),
              )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
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
                        isLoading == true
                            ? Container(
                                height: 60,
                                width: double.infinity,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 53),
                                child: RoundedButton(
                                  text: "Upload",
                                  press: () {
                                    // print(
                                    // "=====phone====$phone======${phoneController.text.length == 10}========");

                                    if (uploadCertifiacate != null) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      upload_Certificate(
                                          widget.petId, widget.vaccineID);
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
        ],
      ),
    );
  }
}
