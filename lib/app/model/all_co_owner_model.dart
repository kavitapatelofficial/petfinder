// To parse this JSON data, do
//
//     final allCoOwnerModel = allCoOwnerModelFromJson(jsonString);

import 'dart:convert';

AllCoOwnerModel allCoOwnerModelFromJson(String str) => AllCoOwnerModel.fromJson(json.decode(str));

String allCoOwnerModelToJson(AllCoOwnerModel data) => json.encode(data.toJson());

class AllCoOwnerModel {
    AllCoOwnerModel({
        this.owners,
        this.message,
        this.success,
    });

    List<Owner>? owners;
    String? message;
    bool? success;

    factory AllCoOwnerModel.fromJson(Map<String, dynamic> json) => AllCoOwnerModel(
        owners: json["owners"] == null ? null : List<Owner>.from(json["owners"].map((x) => Owner.fromJson(x))),
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "owners": owners == null ? null : List<dynamic>.from(owners!.map((x) => x.toJson())),
        "message": message,
        "success": success,
    };
}

class Owner {
    Owner({
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
  
    factory Owner.fromJson(Map<String, dynamic> json) => Owner(
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
