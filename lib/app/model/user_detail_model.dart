// To parse this JSON data, do
//
//     final userDetailModel = userDetailModelFromJson(jsonString);

import 'dart:convert';

UserDetailModel userDetailModelFromJson(String str) => UserDetailModel.fromJson(json.decode(str));

String userDetailModelToJson(UserDetailModel data) => json.encode(data.toJson());

class UserDetailModel {
    UserDetailModel({
        this.message,
        this.success,
        this.user,
    });

    String? message;
    bool? success;
    User? user;

    factory UserDetailModel.fromJson(Map<String, dynamic> json) => UserDetailModel(
        message: json["message"] == null ? null : json["message"],
        success: json["success"] == null ? null : json["success"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "success": success == null ? null : success,
        "user": user == null ? null : user!.toJson(),
    };
}

class User {
    User({
        this.id,
        this.phoneNumber,
        
        this.currentAddress,
        this.email,
        this.isOwner,
        this.name,
        this.permanentAddress,
       
    });

    String? id;
    int? phoneNumber;
   
    EntAddress? currentAddress;
    String? email;
    bool? isOwner;
    String? name;
    EntAddress? permanentAddress;
   

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"] == null ? null : json["_id"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
       
        currentAddress: json["currentAddress"] == null ? null : EntAddress.fromJson(json["currentAddress"]),
        email: json["email"] == null ? null : json["email"],
        isOwner: json["isOwner"] == null ? null : json["isOwner"],
        name: json["name"] == null ? null : json["name"],
        permanentAddress: json["permanentAddress"] == null ? null : EntAddress.fromJson(json["permanentAddress"]),
       
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
       
        "currentAddress": currentAddress == null ? null : currentAddress!.toJson(),
        "email": email == null ? null : email,
        "isOwner": isOwner == null ? null : isOwner,
        "name": name == null ? null : name,
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
        add: json["add"] == null ? null : json["add"],
        city: json["city"] == null ? null : json["city"],
        state: json["state"] == null ? null : json["state"],
        zip: json["zip"] == null ? null : json["zip"],
    );

    Map<String, dynamic> toJson() => {
        "add": add == null ? null : add,
        "city": city == null ? null : city,
        "state": state == null ? null : state,
        "zip": zip == null ? null : zip,
    };
}
