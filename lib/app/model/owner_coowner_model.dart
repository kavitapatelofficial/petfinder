// To parse this JSON data, do
//
//     final ownerAndCooownerModel = ownerAndCooownerModelFromJson(jsonString);

import 'dart:convert';

OwnerAndCooownerModel ownerAndCooownerModelFromJson(String str) =>
    OwnerAndCooownerModel.fromJson(json.decode(str));

String ownerAndCooownerModelToJson(OwnerAndCooownerModel data) =>
    json.encode(data.toJson());

class OwnerAndCooownerModel {
  OwnerAndCooownerModel({
    this.owner,
    this.coOwner,
    this.message,
    this.success,
  });

  Owner? owner;
  List<CoOwner>? coOwner;
  String? message;
  bool? success;

  factory OwnerAndCooownerModel.fromJson(Map<String, dynamic> json) =>
      OwnerAndCooownerModel(
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        coOwner: json["coOwner"] == null
            ? null
            : List<CoOwner>.from(
                json["coOwner"].map((x) => CoOwner.fromJson(x))),
        message: json["message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "owner": owner == null ? null : owner!.toJson(),
        "coOwner": coOwner == null
            ? null
            : List<dynamic>.from(coOwner!.map((x) => x.toJson())),
        "message": message,
        "success": success,
      };
}

class CoOwner {
  CoOwner({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.user,
  });

  String? id;
  String? name;
  dynamic phone;
  String? email;
  String? user;

  factory CoOwner.fromJson(Map<String, dynamic> json) => CoOwner(
        id: json["_id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "user": user,
      };
}

class Owner {
  Owner({this.id, this.phoneNumber, this.role, this.otp, this.name});

  String? id;
  int? phoneNumber;
  int? role;
  String? name;
  int? otp;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        name: json["name"],
        id: json["_id"],
        phoneNumber: json["phoneNumber"],
        role: json["Role"],
        otp: json["otp"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phoneNumber": phoneNumber,
        "Role": role,
        "otp": otp,
        "name": name,
      };
}
