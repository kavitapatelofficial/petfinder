import 'package:flutter/material.dart';
import 'package:petapp/app/model/all_pet_model.dart';

import '../../../component/cards/home_card_one.dart';

class FirstPetScreen extends StatelessWidget {
  final String image;
  final String petid2;
  final String name;
  final String breed;
  final String year;
  final String gender;
  final String rfidNo;
  final VoidCallback onUpadate;
  final VoidCallback onUploadCertifiacte;
  final String vaccineName;
  final String vaccineDate;
  final int vaccineListCount;
  final String isUploadCerti;
  final VoidCallback onDownload;
  final String? Function(String?)? onReview;
  final TextEditingController? writeNoteController;
  final String hintText;
  final AllPetModel allPetModel;
  const FirstPetScreen(
      {Key? key,
      required this.image,
      required this.name,
      required this.breed,
      required this.year,
      required this.gender,
      required this.rfidNo,
      required this.onUpadate,
      required this.onDownload,
      this.onReview,
      this.writeNoteController,
      required this.hintText,
      required this.petid2,
      required this.onUploadCertifiacte,
      required this.vaccineName,
      required this.vaccineDate,
      required this.vaccineListCount,
      required this.isUploadCerti,
      required this.allPetModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeCard(
          image: image,
          name: name,
          year: year,
          gender: gender,
          rfidNo: rfidNo,
          onUpadate: onUpadate,
          onDownload: onDownload,
          breed: breed,
          onReview: onReview,
          writeNoteController: writeNoteController,
          hintText: hintText,
        ),
        


    
       
      ],
    );
  }
}
