// To parse this JSON data, do
//
//     final allPetModel = allPetModelFromJson(jsonString);

import 'dart:convert';

AllPetModel allPetModelFromJson(String str) => AllPetModel.fromJson(json.decode(str));

String allPetModelToJson(AllPetModel data) => json.encode(data.toJson());

class AllPetModel {
    AllPetModel({
        this.result,
        this.message,
        this.success,
    });

    List<Result>? result;
    String? message;
    bool? success;

    factory AllPetModel.fromJson(Map<String, dynamic> json) => AllPetModel(
        result: json["result"] == null ? null : List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
        success: json["success"] == null ? null : json["success"],
    );

    Map<String, dynamic> toJson() => {
        "result": result == null ? null : List<dynamic>.from(result!.map((x) => x.toJson())),
        "message": message == null ? null : message,
        "success": success == null ? null : success,
    };
}

class Result {
    Result({
        this.id,
        this.rfidImage,
        this.rfidNo,
        this.vaccine,
       
        this.user,
        this.uniqueId,
        this.age,
        this.doB,
        this.breed,
        this.gender,
        this.name,
        this.photo,
        this.note
        
    });

    String? id;
    String? rfidImage;
    int? rfidNo;
    List<Vaccine>? vaccine;
  
    String? user;
    String? uniqueId;
    String? age;
    String? doB;
    String? breed;
    String? gender;
    String? name;
    String? photo;
    String? note;
    

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"] == null ? null : json["_id"],
        note: json["note"],
        rfidImage: json["RFIDImage"] == null ? null : json["RFIDImage"],
        rfidNo: json["RFIDNo"] == null ? null : json["RFIDNo"],
        vaccine: json["vaccine"] == null ? null : List<Vaccine>.from(json["vaccine"].map((x) => Vaccine.fromJson(x))),
      
        user: json["user"] == null ? null : json["user"],
        uniqueId: json["uniqueId"] == null ? null : json["uniqueId"],
        age: json["age"] == null ? null : json["age"],
        doB: json["DoB"] == null ? null :json["DoB"],
        breed: json["breed"] == null ? null : json["breed"],
        gender: json["gender"] == null ? null : json["gender"],
        name: json["name"] == null ? null : json["name"],
        photo: json["photo"] == null ? null : json["photo"],
       
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
         "note": note,
        "RFIDImage": rfidImage == null ? null : rfidImage,
        "RFIDNo": rfidNo == null ? null : rfidNo,
        "vaccine": vaccine == null ? null : List<dynamic>.from(vaccine!.map((x) => x.toJson())),
       
        "user": user == null ? null : user,
        "uniqueId": uniqueId == null ? null : uniqueId,
        "age": age == null ? null : age,
        "DoB": doB == null ? null : doB,
        "breed": breed == null ? null : breed,
        "gender": gender == null ? null : gender,
        "name": name == null ? null : name,
        "photo": photo == null ? null : photo,
       
    };
}

class Vaccine {
    Vaccine({
        this.name,
        this.dose,
        this.date,
        this.id,
        this.certificate,
    });

    String? name;
    String? dose;
    String? date;
    int? id;
    String? certificate;

    factory Vaccine.fromJson(Map<String, dynamic> json) => Vaccine(
        name: json["name"] == null ? null : json["name"],
        dose: json["dose"] == null ? null : json["name"].toString(),
        date: json["date"] == null ? null : json["date"],
        id: json["_id"] == null ? null : json["_id"],
        certificate: json["certificate"] == null ? null : json["certificate"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "dose": dose,
        "date": date == null ? null : date,
        "_id": id == null ? null : id,
        "certificate": certificate == null ? null : certificate,
    };
}
