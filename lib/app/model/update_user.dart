// To parse this JSON data, do
//
//     final updateUserModel = updateUserModelFromJson(jsonString);

import 'dart:convert';

UpdateUserModel updateUserModelFromJson(String str) => UpdateUserModel.fromJson(json.decode(str));

String updateUserModelToJson(UpdateUserModel data) => json.encode(data.toJson());

class UpdateUserModel {
    UpdateUserModel({
        this.message,
        this.success,
        this.doc,
    });

    String? message;
    bool? success;
    Doc? doc;

    factory UpdateUserModel.fromJson(Map<String, dynamic> json) => UpdateUserModel(
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
        this.isOwner,
       
        this.currentAddress,
        this.email,
        this.name,
        this.permanentAddress,
    });

    String? id;
    int? phoneNumber;
    int? otp;
    dynamic isOwner;
   
    EntAddress? currentAddress;
    String? email;
    String? name;
    EntAddress? permanentAddress;

    factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        id: json["_id"],
        phoneNumber: json["phoneNumber"],
        otp: json["otp"],
        isOwner: json["isOwner"],
       
        currentAddress: json["currentAddress"] == null ? null : EntAddress.fromJson(json["currentAddress"]),
        email: json["email"],
        name: json["name"],
        permanentAddress: json["permanentAddress"] == null ? null : EntAddress.fromJson(json["permanentAddress"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "phoneNumber": phoneNumber,
        "otp": otp,
        "isOwner": isOwner,
       
        "currentAddress": currentAddress == null ? null : currentAddress!.toJson(),
        "email": email,
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
