// To parse this JSON data, do
//
//     final allOwnerModel = allOwnerModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AllOwnerModel allOwnerModelFromJson(String str) => AllOwnerModel.fromJson(json.decode(str));

String allOwnerModelToJson(AllOwnerModel data) => json.encode(data.toJson());

class AllOwnerModel {
    AllOwnerModel({
        this.success,
        this.message,
        this.data,
    });

    bool? success;
    String? message;
    List<Datum>? data;

    factory AllOwnerModel.fromJson(Map<String, dynamic> json) => AllOwnerModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.phoneNumber,
        this.otp,
       
        this.currentAddress,
        this.email,
        this.isOwner,
        this.name,
        this.permanentAddress,
    });

    String? id;
    int? phoneNumber;
    int? otp;
    
    EntAddress? currentAddress;
    String? email;
    bool? isOwner;
    String? name;
    EntAddress? permanentAddress;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        phoneNumber: json["phoneNumber"],
        otp: json["otp"],
       
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
    // ignore: unnecessary_question_mark
    dynamic? zip;

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
