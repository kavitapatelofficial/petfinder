// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:petapp/app/component/buttons/defaultbutton.dart';
import 'package:petapp/app/component/headings/my_headingtext.dart';
import 'package:petapp/app/constent/api_urls.dart';
import 'package:petapp/app/constent/colors.dart';
import 'package:petapp/app/model/all_breed_model.dart';
import 'package:petapp/app/model/pet_detail_model.dart';
import 'package:http/http.dart' as http;
import 'package:petapp/app/modules/home/views/home_view2.dart';

import '../../../../services/base_client.dart';

import '../../../component/textformfields/my_textform_field.dart';
import '../../../component/textformfields/textform_field_icon.dart';
import '../../../constent/textthem.dart';
import '../../../model/createpet_response.dart';
import '../../home/views/home_view.dart';

class PetDetailView extends StatefulWidget {
  final String? petId;
  const PetDetailView({Key? key, this.petId}) : super(key: key);

  @override
  State<PetDetailView> createState() => _PetDetailViewState();
}

class _PetDetailViewState extends State<PetDetailView> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController breedController = TextEditingController();

  final TextEditingController genderController = TextEditingController();

  final TextEditingController dobController = TextEditingController();
  final TextEditingController sterilledController = TextEditingController();
  final TextEditingController petTypeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  BaseClient baseClient = BaseClient();
  final ImagePicker _picker = ImagePicker();

  // ? signupModel;
  bool isLoading = false;
  bool isULoading = false;

  String phone = "";

  String? idproof;

  File? upload_idproof;

  bool? isSterilised;
  String? selectedValue1;
  bool? selectedValue2;
  String? selectedValue4;
  String? selectedValue5;
  String? selectedValue6;
  String? selectedValue7;

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
        isULoading = true;
      });
      var data = {
        'id': widget.petId ?? '${BaseClient.box2.read("pet_id")}',
        'name': nameController.text,
        'breed': breedController.text,
        'gender': genderController.text,
        'dob': dobController.text,
        'type': petTypeController.text.toString(),
        'sterialized': isSterilised.toString()
      };

      var petId = widget.petId ?? '${BaseClient.box2.read("pet_id")}';
      var request = http.MultipartRequest(
          'PUT', Uri.parse('https://petfinder.booksica.in/pet/update'));
      request.fields.addAll({
        'petId': petId,
        'name': nameController.text,
        'breed': breedController.text,
        'gender': genderController.text,
        'dob': dobController.text,
        'type': petTypeController.text.toString(),
        'sterialized': isSterilised.toString(),
        "isOwner": selectedValue2.toString()
      });

      if (upload_idproof != null) {
        request.files.add(
            await http.MultipartFile.fromPath('photo', upload_idproof!.path));
      } else {
        request.fields.addAll({
          'photo': petDetailModel!.data!.photo == null
              ? ""
              : petDetailModel!.data!.photo!
        });
      }

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(
            "====response.statusCode========${response.statusCode}======Pet updated successfully===================");
        // ispetUpdate = false;
        var data1 = await response.stream.bytesToString();
        var data2 = jsonDecode(data1);
        print("==============data====$data2===============");
        if (data2['success'] == true) {
          setState(() {
            isULoading = false;
          });
          Fluttertoast.showToast(
            msg: "${data2['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: AppColor.neturalGreen,
            textColor: Colors.white,
          );
          Get.offAll(HomeViewTwo(
            currentIndex: 1,
          ));
        } else {
          setState(() {
            isULoading = false;
          });
          Fluttertoast.showToast(
            msg: "${data2['message']}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: AppColor.neturalRed,
            textColor: Colors.white,
          );
        }
      } else {
        setState(() {
          isULoading = false;
        });
      }
    } finally {
      setState(() {
        isULoading = false;
      });
    }
  }

  PetDetailModel? petDetailModel;

  getallpet() async {
    isLoading = true;
    var url = ConstantsUrls.baseURL + ConstantsUrls.getAllPetByUser;
    var response = await baseClient.get(false, ConstantsUrls.baseURL,
        "${ConstantsUrls.getPetById}${widget.petId}");
    if (response != null) {
      petDetailModel = petDetailModelFromJson(response);
      if (petDetailModel!.data != null) {
        nameController.text = petDetailModel!.data!.name == null
            ? ""
            : petDetailModel!.data!.name!;
        selectedValue7 = petDetailModel!.data!.breed == null
            ? ""
            : petDetailModel!.data!.breed!;
        selectedValue5 = petDetailModel!.data!.gender == null
            ? ""
            : petDetailModel!.data!.gender!;
        dobController.text = petDetailModel!.data!.doB == null
            ? ""
            : DateFormat('yyyy-MM-dd')
                .format(DateTime.parse(petDetailModel!.data!.doB!));

        selectedValue1 = petDetailModel!.data!.type.toString();
        selectedValue2 = petDetailModel!.data!.isOwner;
        isSterilised = petDetailModel!.data!.sterialized!;

        print("pet tyepe =${petDetailModel!.data!.type}=");
        print("pet tyepe =${petDetailModel!.data!.type}=");
      }
    }
    isLoading = false;
    setState(() {});
  }

  isupadete() {
    if (widget.petId != null) {
      getallpet();
    }
  }

  @override
  void initState() {
    isupadete();
    getBreed();
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.maybeOf(context)!.size;
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColor.accentWhite,
          body: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 37,
                          ),
                          const MyHeadingTwoText(
                              text: "Tell Us About Your Pet"),
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
                                style:
                                    Texttheme.bodyText1.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                _uploadocumen(context);
                              },
                              child: widget.petId == null
                                  ? upload_idproof == null
                                      ? Image.asset("assets/images/adhar.png",
                                          height: 132, width: 132)
                                      : Container(
                                          height: 100,
                                          width: 132,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Image.file(upload_idproof!),
                                        )
                                  : upload_idproof == null
                                      ? Container(
                                          margin: const EdgeInsets.all(10),
                                          alignment: Alignment.topRight,
                                          height: 132,
                                          width: 132,
                                          decoration: BoxDecoration(
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  onError: (exception,
                                                          stackTrace) =>
                                                      const Icon(Icons.error),
                                                  image: NetworkImage(
                                                      "${ConstantsUrls.baseURL}/api/${petDetailModel!.data!.photo}"))),
                                          child: CircleAvatar(
                                              backgroundColor:
                                                  AppColor.neturalGreen,
                                              child: Icon(
                                                Icons.edit,
                                                color: AppColor.accentWhite,
                                              )),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.all(10),
                                          height: 100,
                                          width: 132,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  onError: (exception,
                                                          stackTrace) =>
                                                      const Icon(Icons.error),
                                                  image: FileImage(
                                                      upload_idproof!)),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
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
                                  style: Texttheme.bodyText1
                                      .copyWith(fontSize: 12),
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
                                  child: DropdownButtonHideUnderline(
                                    child: ButtonTheme(
                                      alignedDropdown: true,
                                      child: DropdownButtonFormField(
                                          // itemHeight: 60,
                                          alignment:
                                              AlignmentDirectional.bottomEnd,
                                          isDense: true,
                                          isExpanded: true,
                                          decoration: InputDecoration(
                                            alignLabelWithHint: true,
                                            isDense: true,
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xffE5E4F2),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xffE5E4F2),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                color: Color(0xffE5E4F2),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                            ),
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: const Color(0xffE5E4F2),
                                          ),
                                          validator: (value) => value == null
                                              ? "Type of Pet"
                                              : null,
                                          dropdownColor:
                                              const Color(0xffE5E4F2),
                                          value: selectedValue1,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedValue1 = newValue!;
                                              petTypeController.text =
                                                  selectedValue1!;
                                            });
                                          },
                                          items: dropdownItems1),
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
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                ),
                                SizedBox(
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
                          SizedBox(
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
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xffE5E4F2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0),
                                          ),
                                          border: InputBorder.none,
                                          filled: true,
                                          fillColor: const Color(0xffE5E4F2),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Color(0xffE5E4F2),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(0),
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
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                                            breedController.text =
                                                selectedValue7!;
                                          });

                                          //Do something when changing the item if you want.
                                        },
                                        onSaved: (value) {
                                          setState(() {
                                            selectedValue7 = value.toString();
                                            breedController.text =
                                                selectedValue7!;
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
                                    child: TextFormFieldIcon(
                                      read: true,
                                      ontab: () async {
                                        var date = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime(2100));
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
                                            dobController.text = date
                                                .toString()
                                                .substring(0, 10);
                                          },
                                          child:
                                              const Icon(Icons.calendar_month)),
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
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 5),
                                        hintText: " Type of Ownership?",
                                        isDense: true,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xffE5E4F2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xffE5E4F2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            color: Color(0xffE5E4F2),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: const Color(0xffE5E4F2),
                                      ),
                                      validator: (value) => value == null
                                          ? "Type of Ownership?"
                                          : null,
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
                            height: 16,
                          ),
                          isULoading
                              ? Container(
                                  height: 60,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : RoundedButton(
                                  text: "Update",
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
    if (widget.petId != null) {
      if (isValid) {
        // print(phoneController.text);

        signup1();
      } else {}
    } else {
      if (upload_idproof != null) {
        if (isValid) {
          // print(phoneController.text);

          signup1();
        } else {
          Fluttertoast.showToast(
            msg: "Red highlighted field required",
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
          msg: "Please upload chip certificate",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColor.neturalRed,
          textColor: Colors.white,
        );
        return;
      }
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
}
