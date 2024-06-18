// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petapp/app/component/buttons/defaultbutton.dart';
import 'package:petapp/app/component/headings/my_headingtext.dart';
import 'package:petapp/app/constent/api_urls.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/model/all_breed_model.dart';
import 'package:petapp/app/model/all_vaccine_model.dart';
import 'package:petapp/app/modules/signup/views/signup_screen_two.dart';
import 'package:petapp/app/modules/signup/views/statusbar.dart';
import 'package:http/http.dart' as http;

import '../../../../services/base_client.dart';

import '../../../component/textformfields/my_textform_field.dart';
import '../../../component/textformfields/textform_field_icon.dart';
import '../../../constent/textthem.dart';
import '../../../model/createpet_response.dart';

class SignupViewSix extends StatefulWidget {
  const SignupViewSix({Key? key}) : super(key: key);

  @override
  State<SignupViewSix> createState() => _SignupViewSixState();
}

class _SignupViewSixState extends State<SignupViewSix> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController nameController = TextEditingController();

  final TextEditingController breedController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  final TextEditingController dobController = TextEditingController();
  final TextEditingController vaccinDateController = TextEditingController();

  final TextEditingController vacciaNameController = TextEditingController();

  final TextEditingController doseController = TextEditingController();
  final TextEditingController petTypeController = TextEditingController();
  final TextEditingController sterilledController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  BaseClient baseClient = BaseClient();

  List<DropdownMenuItem<String>> get dropdownItems1 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Dog"), value: "Dog"),
      const DropdownMenuItem(child: Text("Cat"), value: "Cat"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<bool>> get dropdownItems2 {
    List<DropdownMenuItem<bool>> menuItems = [
      const DropdownMenuItem(
          child: Text("Guardian (Legal Owner)"), value: true),
      const DropdownMenuItem(child: Text("Volunteer"), value: false),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems3 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Anti-rabies"), value: "Anti-rabies"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems4 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text("7-1 or similar"), value: "7-1 or similar"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get dropdownItems5 {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Male"), value: "Male"),
      const DropdownMenuItem(child: Text("Female"), value: "Female"),
      const DropdownMenuItem(child: Text("Other"), value: "Other"),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<bool>> get dropdownItems6 {
    List<DropdownMenuItem<bool>> menuItems = [
      const DropdownMenuItem(child: Text("Yes(Is Sterilised)"), value: true),
      const DropdownMenuItem(child: Text("No(Is Sterilised)"), value: false),
    ];
    return menuItems;
  }

 
  bool isSterilised = false;
  String? selectedValue1;
  bool? selectedValue2;
  String? selectedValue3;
  String? selectedValue4;
  String? selectedValue5;
  String? selectedValue6;
  String? selectedValue7;

  // ? signupModel;
  bool isLoading = false;
  bool tandcvalue = false;

  String phone = "";

  String? idproof;

  File? upload_idproof;

  _getdocuments() async {
    var result = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );

    if (result != null) {
      var file = File(result.path);
      setState(() {
        upload_idproof = file;
        // uploadidNameController.text = upload_idproof!.path.split("/").last;
      });

      Navigator.of(context).pop();
    } else {
      // User canceled the picker
    }
  }

  signup1() async {
    try {
      setState(() {
        isLoading = true;
      });

      var data = {
        'petId': '${BaseClient.box2.read("pet_id")}',
        'name': nameController.text,
        'breed': breedController.text,
        'gender': genderController.text,
        'vaccineName': vacciaNameController.text,
        'vaccineDose': doseController.text,
        'dob': dobController.text,
        'vaccineDate': vaccinDateController.text,
        'type': petTypeController.text,
        'sterialized': isSterilised.toString(),
        "isOwner": selectedValue2
      };

      print("data  $data");
      var request = http.MultipartRequest(
          'PUT', Uri.parse('https://petfinder.booksica.in/pet/update'));
      request.fields.addAll({
        'petId': '${BaseClient.box2.read("pet_id")}',
        'name': nameController.text,
        'breed': breedController.text,
        'gender': genderController.text,
        'vaccineName': vacciaNameController.text.isEmpty?"":vacciaNameController.text,
        'vaccineDose': doseController.text.isEmpty?"":doseController.text,
        'dob': dobController.text,
        'vaccineDate': vaccinDateController.text.isEmpty?"": vaccinDateController.text,
        'type': petTypeController.text,
        'sterialized': isSterilised.toString(),
        "isOwner": selectedValue2!.toString()
      });

      if (upload_idproof!.path.isNotEmpty) {
        request.files.add(
            await http.MultipartFile.fromPath('photo', upload_idproof!.path));
      }

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var data2 = await response.stream.bytesToString();

        print(
            "=====pet update==========data2=======$data2====================");
        var data3 = jsonDecode(data2);
        if (data3['success'] == true) {
          var data = createPetModelFromJson(data2);

          setState(() {
            isLoading = false;
          });

          Fluttertoast.showToast(
            msg: "${data3['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: AppColor.neturalGreen,
            textColor: Colors.white,
          );
          Get.offAll(const SignupViewTwo());
        } else {
          setState(() {
            isLoading = false;
          });

          Fluttertoast.showToast(
            msg: "Pet created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: AppColor.neturalGreen,
            textColor: Colors.white,
          );
        }
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getBreed();
    getVaccine();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.accentWhite,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const MyHeadingText(text: "Sign Up"),
                    const SizedBox(
                      height: 24,
                    ),
                    const StatusBar(
                      status: '4',
                    ),
                    const SizedBox(
                      height: 37,
                    ),
                    const MyHeadingTwoText(text: "Tell Us About Your Pet"),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Upload your Pet’s Latest  Photo",
                          textAlign: TextAlign.center,
                          style: Texttheme.bodyText1.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                    InkWell(
                        onTap: () {
                          _uploadocumen(context);
                        },
                        child: upload_idproof == null
                            ? Image.asset("assets/images/adhar.png",
                                height: 132, width: 132)
                            : Container(
                                margin: const EdgeInsets.all(10),
                                height: 100,
                                width: 132,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        onError: (exception, stackTrace) =>
                                            const Icon(Icons.error),
                                        image: FileImage(upload_idproof!)),
                                    borderRadius: BorderRadius.circular(10)),
                              )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 274,
                          child: Text(
                            "   If younger than 10 months, we will remind you to update your dog’s photo every 30 days.",
                            textAlign: TextAlign.center,
                            style: Texttheme.bodyText1.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: screenSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/Home/Dog.png",
                            color: AppColor.accentLightGrey,
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: DropdownButtonFormField2(
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
                                'Select Your pet',
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
                              items: dropdownItems1,
                              value: selectedValue1,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select pet';
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  selectedValue1 = value.toString();
                                  petTypeController.text = selectedValue1!;
                                });
                                //Do something when changing the item if you want.
                              },
                              onSaved: (value) {
                                selectedValue1 = value.toString();
                                petTypeController.text = selectedValue1!;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: screenSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: MyTextFormField(
                              hintText: 'Name',
                              controller: nameController,
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Name required";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        isBreedLoading == true
                            ? SizedBox()
                            : Expanded(
                                child: DropdownButtonFormField2(
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
                                  ),
                                  isExpanded: true,
                                  hint: const Text(
                                    'Breed',
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
                                  items: _allBreedModel!.breed!.map((e) {
                                    return DropdownMenuItem(
                                        child: Text("${e!.name}"),
                                        value: "${e.name}");
                                  }).toList(),
                                  value: selectedValue7,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select breed';
                                    }
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue7 = value.toString();
                                      breedController.text = selectedValue7!;
                                    });

                                    //Do something when changing the item if you want.
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      selectedValue7 = value.toString();
                                      breedController.text = selectedValue7!;
                                    });
                                  },
                                ),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: DropdownButtonFormField2(
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
                              'Male',
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
                            items: dropdownItems5,
                            value: selectedValue5,
                            validator: (value) {
                              if (value == null) {
                                return 'Please select SEX';
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedValue5 = value.toString();
                                genderController.text = selectedValue5!;
                              });
                              //Do something when changing the item if you want.
                            },
                            onSaved: (value) {
                              setState(() {
                                selectedValue5 = value.toString();
                                genderController.text = selectedValue5!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: screenSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/Home/Birthday.png",
                            color: AppColor.accentLightGrey,
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                var date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());
                                dobController.text =
                                    date.toString().substring(0, 10);
                              },
                              child: MyTextFormField(
                                read: true,
                                ontab: () async {
                                  var date = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime.now());
                                  dobController.text =
                                      date.toString().substring(0, 10);
                                },
                                hintText: 'DOB',
                                // prefixIcon: Icons.email,
                                icon: GestureDetector(
                                    onTap: () async {
                                      var date = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now());
                                      dobController.text =
                                          date.toString().substring(0, 10);
                                    },
                                    child: const Icon(Icons.calendar_month)),
                                controller: dobController,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Dob required";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: screenSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: DropdownButtonFormField2(
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
                                'Is Sterilised',
                                style: TextStyle(fontSize: 14),
                              ),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                              buttonHeight: 50,
                              // buttonPadding:
                              //     const EdgeInsets.only(left: 20, right: 10),
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              items: dropdownItems6,
                              value: isSterilised,
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select sterilised';
                                }
                              },
                              onChanged: (bool? value) {
                                setState(() {
                                  isSterilised = value!;
                                });
                                //Do something when changing the item if you want.
                              },
                              onSaved: (bool? value) {
                                setState(() {
                                  isSterilised = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const MyBodyText(text: "Last Vaccination Details"),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: screenSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/Home/injection.png",
                            color: AppColor.accentLightGrey,
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: DropdownButtonFormField2(
                                itemHeight: 60,
                                //
                                alignment: AlignmentDirectional.bottomEnd,
                                // isDense: true,
                               
                                isExpanded: true,
                                decoration: InputDecoration(
                                    hintText: "Anti-rabies",
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 12,horizontal:8),
                                  isDense: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xffE5E4F2),
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
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
                                ),
                                // validator: (value) =>
                                //     value == null ? "$selectedValue3" : null,
                                // dropdownColor:
                                //     const Color.fromRGBO(229, 228, 242, 1),
                                value: selectedValue3,
                                onChanged: (newValue) {
                                  setState(() {
                                    selectedValue3 = newValue!.toString();
                                    vacciaNameController.text = selectedValue3!;
                                  });
                                },
                                items: dropdownItems3),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              var date = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now());
                              vaccinDateController.text =
                                  date.toString().substring(0, 10);
                            },
                            child: MyTextFormField(
                              read: true,
                              ontab: () async {
                                var date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now());
                                vaccinDateController.text =
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
                                    vaccinDateController.text =
                                        date.toString().substring(0, 10);
                                  },
                                  child: const Icon(Icons.calendar_month)),
                              controller: vaccinDateController,
                              // validate: (value) {
                              //   if (value!.isEmpty) {
                              //     return "Vaccination Date required";
                              //   } else {
                              //     return null;
                              //   }
                              // },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: screenSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          isVaccineLoading == true
                              ? SizedBox()
                              : Expanded(
                                  child: DropdownButtonFormField2(
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
                                    // validator: (value) {
                                    //   if (value == null) {
                                    //     return 'Please select dose';
                                    //   }
                                    // },
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
                                ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: screenSize.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                            width: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: DropdownButtonFormField2(
                                itemHeight: 60,
                                alignment: AlignmentDirectional.bottomEnd,
                                isDense: true,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 12),
                                  hintText: " Type of Ownership?",
                                  isDense: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0xffE5E4F2),
                                    ),
                                    borderRadius: BorderRadius.circular(0),
                                  ),
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
                                ),
                                validator: (value) =>
                                    value == null ? "Type of Ownership?" : null,
                                // dropdownColor: const Color(0xffE5E4F2),
                                value: selectedValue2,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    selectedValue2 = newValue!;
                                    // petTypeController.text=selectedValue!;
                                  });
                                },
                                items: dropdownItems2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: this.tandcvalue,
                          onChanged: (bool? value) {
                            setState(() {
                              this.tandcvalue = value!;
                            });
                          },
                        ),
                        const Text(
                          "Terms and Conditions",
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 12,
                              color: Colors.black),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "1 Year Free Membership till May 2023",
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 14,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    isLoading
                        ? Container(
                            width: double.infinity,
                            height: 60,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : RoundedButton(
                            text: "Submit",
                            press: () {
                              validateSignUp();
                              // Get.offAll(HomeView());
                            },
                          ),
                    const SizedBox(
                      height: 73,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void _uploadocumen(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
      ),
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              const SizedBox(height: 20),
              ListTile(
                  title: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'Pick Document',
                      style: Texttheme.title.copyWith(color: Colors.blue),
                    ),
                  ),
                  onTap: () async {
                    _getdocuments();
                  }),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        );
      },
    );
  }

  void validateSignUp() {
    final isValid = _formKey.currentState!.validate();
    // print(
    // "=====phone====$phone======${phoneController.text.length == 10}========");

    if (upload_idproof != null) {
      if (isValid) {
        // print(phoneController.text);

        signup1();
      } else {
        Fluttertoast.showToast(
          msg: "Red Highlighted field required",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColor.neturalRed,
          textColor: Colors.white,
        );
        return;
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please upload  pet image",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColor.neturalRed,
        textColor: Colors.white,
      );
      return;
    }
  }

  AllBreedModel? _allBreedModel;
  bool isBreedLoading = true;

  getBreed() async {
    isBreedLoading = true;
    var response = await baseClient.get(
        false, ConstantsUrls.baseURL, "${ConstantsUrls.GetAllBreed}");
    _allBreedModel = allBreedModelFromJson(response);
    isBreedLoading = false;
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
}
