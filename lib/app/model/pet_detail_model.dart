// To parse this JSON data, do
//
//     final petDetailModel = petDetailModelFromJson(jsonString);

import 'dart:convert';

PetDetailModel petDetailModelFromJson(String str) => PetDetailModel.fromJson(json.decode(str));

String petDetailModelToJson(PetDetailModel data) => json.encode(data.toJson());

class PetDetailModel {
    PetDetailModel({
        this.success,
        this.message,
        this.data,
    });

    bool? success;
    String? message;
    Data? data;

    factory PetDetailModel.fromJson(Map<String, dynamic> json) => PetDetailModel(
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
        this.rfidImage,
        this.rfidNo,
       
        this.user,
        this.uniqueId,
        this.doB,
        this.breed,
        this.gender,
        this.name,
        this.photo,
        this.updatedAt,
        this.vaccine,
        this.note,
        this.isMissing,
          this.isOwner,
        this.lastSeen, this.sterialized, this.type
       
    });

    String? id;
    String? rfidImage;
    int? rfidNo;
   
    String? user;
    String? uniqueId;
    String? doB;
    String? breed;
    String? gender;
    String? name;
    String? photo;
    DateTime? updatedAt;
    List<Vaccine>? vaccine;
    String? note;
    bool? isMissing;
    String? lastSeen;
    bool? sterialized;
     bool? isOwner;

    String? type;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        rfidImage: json["RFIDImage"],
        rfidNo: json["RFIDNo"],
      
       
        user: json["user"],
        uniqueId: json["uniqueId"],
        doB: json["DoB"],
        breed: json["breed"],
        gender: json["gender"],
        name: json["name"],
        photo: json["photo"],
         isOwner: json["isOwner"] == null ? null : json["isOwner"],
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        vaccine: json["vaccine"] == null ? null : List<Vaccine>.from(json["vaccine"].map((x) => Vaccine.fromJson(x))),
        note: json["note"],
        isMissing: json["isMissing"],
         lastSeen: json["lastSeen"] == null ? null : json["lastSeen"],

            sterialized: json["sterialized"] == null ? null : json["sterialized"],
        type: json["type"] == null ? null : json["type"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "RFIDImage": rfidImage,
        "RFIDNo": rfidNo,
        
        "user": user,
        "uniqueId": uniqueId,
        "DoB": doB,
        "breed": breed,
        "gender": gender,
        "name": name,
        "photo": photo,
         "isOwner": isOwner == null ? null : isOwner,
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "vaccine": vaccine == null ? null : List<dynamic>.from(vaccine!.map((x) => x.toJson())),
        "note": note,
        "isMissing": isMissing,
       
        "lastSeen": lastSeen == null ? null : lastSeen,
         "sterialized": sterialized == null ? null : sterialized,
        "type": type == null ? null : type,
 
    };
}

class Vaccine {
    Vaccine({
        this.name,
        this.dose,
        this.vaccineDate,
    });

    String? name;
    String? dose;
    String? vaccineDate;

    factory Vaccine.fromJson(Map<String, dynamic> json) => Vaccine(
        name: json["name"],
        dose: json["dose"]== null ? null :json["dose"].toString(),
        vaccineDate: json["vaccineDate"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "dose": dose,
        "vaccineDate": vaccineDate,
    };
}
