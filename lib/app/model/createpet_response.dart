// To parse this JSON data, do
//
//     final createPetModel = createPetModelFromJson(jsonString);

import 'dart:convert';

CreatePetModel createPetModelFromJson(String str) =>
    CreatePetModel.fromJson(json.decode(str));

String createPetModelToJson(CreatePetModel data) => json.encode(data.toJson());

class CreatePetModel {
  CreatePetModel({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory CreatePetModel.fromJson(Map<String, dynamic> json) => CreatePetModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.rfidImage,
    this.rfidNo,
    this.user,
    this.id,
  });

  String? rfidImage;
  int? rfidNo;

  String? user;

  String? id;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        rfidImage: json["RFIDImage"] == null ? null : json["RFIDImage"],
        rfidNo: json["RFIDNo"] == null ? null : json["RFIDNo"],
        user: json["user"] == null ? null : json["user"],
        id: json["_id"] == null ? null : json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "RFIDImage": rfidImage == null ? null : rfidImage,
        "RFIDNo": rfidNo == null ? null : rfidNo,
        "user": user == null ? null : user,
        "_id": id == null ? null : id,
      };
}
