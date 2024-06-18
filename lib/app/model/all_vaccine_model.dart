// To parse this JSON data, do
//
//     final allVaccineModel = allVaccineModelFromJson(jsonString);

import 'dart:convert';

AllVaccineModel allVaccineModelFromJson(String str) => AllVaccineModel.fromJson(json.decode(str));

String allVaccineModelToJson(AllVaccineModel data) => json.encode(data.toJson());

class AllVaccineModel {
    AllVaccineModel({
        this.success,
        this.message,
        this.vaccine,
    });

    bool? success;
    String? message;
    List<Vaccine>? vaccine;

    factory AllVaccineModel.fromJson(Map<String, dynamic> json) => AllVaccineModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        vaccine: json["vaccine"] == null ? null : List<Vaccine>.from(json["vaccine"].map((x) => Vaccine.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "vaccine": vaccine == null ? null : List<dynamic>.from(vaccine!.map((x) => x.toJson())),
    };
}

class Vaccine {
    Vaccine({
        this.name,
        this.dose,
        this.date,
        this.certificate,
        this.id,
    });

    String? name;
    int? dose;
    String? date;
    String? certificate;
    int? id;

    factory Vaccine.fromJson(Map<String, dynamic> json) => Vaccine(
        name: json["name"] == null ? null : json["name"],
        dose: json["dose"] == null ? null : json["dose"],
        date: json["date"] == null ? null : json["date"],
        certificate: json["certificate"] == null ? null : json["certificate"],
        id: json["_id"] == null ? null : json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "dose": dose == null ? null : dose,
        "date": date == null ? null : date,
        "certificate": certificate == null ? null : certificate,
        "_id": id == null ? null : id,
    };
}
