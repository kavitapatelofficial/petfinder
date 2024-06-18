// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.doc,
    this.message,
    this.success,
    this.userLogin,
  });

  Doc? doc;
  String? message;
  bool? success;
  bool? userLogin;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        doc: json["doc"] == null ? null : Doc.fromJson(json["doc"]),
        message: json["message"],
        success: json["success"],
        userLogin: json["userLogin"],
      );

  Map<String, dynamic> toJson() => {
        "doc": doc == null ? null : doc!.toJson(),
        "message": message,
        "success": success,
        "userLogin": userLogin,
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

    factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        phoneNumber: json["phoneNumber"],
        otp: json["otp"],
       
        role: json["Role"],
        currentAddress: json["currentAddress"] == null ? null : EntAddress.fromJson(json["currentAddress"]),
        email: json["email"],
        isOwner: json["isOwner"],
        name: json["name"],
        permanentAddress: json["permanentAddress"] == null ? null : EntAddress.fromJson(json["permanentAddress"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "phoneNumber": phoneNumber,
        "otp": otp,
       
        "Role": role,
        "currentAddress": currentAddress == null ? null : currentAddress!.toJson(),
        "email": email,
        "isOwner": isOwner,
        "name": name,
        "permanentAddress": permanentAddress == null ? null : permanentAddress!.toJson(),
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
