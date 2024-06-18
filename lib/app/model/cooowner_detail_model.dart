// To parse this JSON data, do
//
//     final coownerDetailModel = coownerDetailModelFromJson(jsonString);

import 'dart:convert';

CoownerDetailModel coownerDetailModelFromJson(String str) => CoownerDetailModel.fromJson(json.decode(str));

String coownerDetailModelToJson(CoownerDetailModel data) => json.encode(data.toJson());

class CoownerDetailModel {
    CoownerDetailModel({
        this.success,
        this.message,
        this.data,
    });

    bool? success;
    String? message;
    Data? data;

    factory CoownerDetailModel.fromJson(Map<String, dynamic> json) => CoownerDetailModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.name,
        this.phone,
        this.email,
        this.user,
     
    });

    String? id;
    String? name;
    int? phone;
    String? email;
    String? user;
   
    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
