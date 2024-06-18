// To parse this JSON data, do
//
//     final signupModel = signupModelFromJson(jsonString);

import 'dart:convert';

SignupModel signupModelFromJson(String str) => SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
    SignupModel({
        this.doc,
        this.userLogin,
        this.message,
        this.success,
    });

    Doc? doc;
    bool? userLogin;
    String? message;
    bool? success;

    factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        doc: json["doc"] == null ? null : Doc.fromJson(json["doc"]),
        userLogin: json["userLogin"],
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "doc": doc == null ? null : doc!.toJson(),
        "userLogin": userLogin,
        "message": message,
        "success": success,
    };
}

class Doc {
    Doc({
        this.phoneNumber,
        this.otp,
       
        this.role,
        this.id,
    });

    int? phoneNumber;
    int? otp;
   
    int? role;
    String? id;

    factory Doc.fromJson(Map<String, dynamic> json) => Doc(
        phoneNumber: json["phoneNumber"],
        otp: json["otp"],
      
        role: json["Role"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "phoneNumber": phoneNumber,
        "otp": otp,
       
        "Role": role,
        "_id": id,
    };
}
