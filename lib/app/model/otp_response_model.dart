// To parse this JSON data, do
//
//     final otpResponseModel = otpResponseModelFromJson(jsonString);

import 'dart:convert';

OtpResponseModel otpResponseModelFromJson(String str) =>
    OtpResponseModel.fromJson(json.decode(str));

String otpResponseModelToJson(OtpResponseModel data) =>
    json.encode(data.toJson());

class OtpResponseModel {
  OtpResponseModel({
    this.message,
    this.success,
    this.doc,
  });

  String? message;
  bool? success;
  Doc? doc;

  factory OtpResponseModel.fromJson(Map<String, dynamic> json) =>
      OtpResponseModel(
        message: json["message"],
        success: json["success"],
        doc: json["doc"] == null ? null : Doc.fromJson(json["doc"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
        "doc": doc == null ? null : doc!.toJson(),
      };
}

class Doc {
  Doc({
    this.id,
    this.phoneNumber,
    this.otp,
    this.role,
    this.currentAddress,
    this.email,
    this.isOwner,
    this.name,
    this.token,
    this.permanentAddress,
  });

  String? id;
  int? phoneNumber;
  int? otp;

  int? role;
  EntAddress? currentAddress;
  String? email;
  bool? isOwner;
  String? name;
  EntAddress? permanentAddress;
  String? token;

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        phoneNumber: json["phoneNumber"],
        otp: json["otp"],
        token: json["token"],
        role: json["Role"],
        currentAddress: json["currentAddress"] == null
            ? null
            : EntAddress.fromJson(json["currentAddress"]),
        email: json["email"],
        isOwner: json["isOwner"],
        name: json["name"],
        permanentAddress: json["permanentAddress"] == null
            ? null
            : EntAddress.fromJson(json["permanentAddress"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phoneNumber": phoneNumber,
        "otp": otp,
        "token": token,
        "Role": role,
        "currentAddress":
            currentAddress == null ? null : currentAddress!.toJson(),
        "email": email,
        "isOwner": isOwner,
        "name": name,
        "permanentAddress":
            permanentAddress == null ? null : permanentAddress!.toJson(),
      };
}

class EntAddress {
  EntAddress({
    this.add,
    this.city,
    this.state,
    this.zip,
  });

  String? add;
  String? city;
  String? state;
  String? zip;

  factory EntAddress.fromJson(Map<String, dynamic> json) => EntAddress(
        add: json["add"],
        city: json["city"],
        state: json["state"],
        zip: json["zip"],
      );

  Map<String, dynamic> toJson() => {
        "add": add,
        "city": city,
        "state": state,
        "zip": zip,
      };
}
