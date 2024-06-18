// To parse this JSON data, do
//
//     final allBreedModel = allBreedModelFromJson(jsonString);

import 'dart:convert';

AllBreedModel allBreedModelFromJson(String str) => AllBreedModel.fromJson(json.decode(str));

String allBreedModelToJson(AllBreedModel data) => json.encode(data.toJson());

class AllBreedModel {
    AllBreedModel({
        this.success,
        this.message,
        this.breed,
    });

    bool? success;
    String? message;
    List<Breed>? breed;

    factory AllBreedModel.fromJson(Map<String, dynamic> json) => AllBreedModel(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        breed: json["breed"] == null ? null : List<Breed>.from(json["breed"].map((x) => Breed.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "breed": breed == null ? null : List<dynamic>.from(breed!.map((x) => x.toJson())),
    };
}

class Breed {
    Breed({
        this.name,
        this.id,
    });

    String? name;
    int? id;

    factory Breed.fromJson(Map<String, dynamic> json) => Breed(
        name: json["name"] == null ? null : json["name"],
        id: json["_id"] == null ? null : json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "_id": id == null ? null : id,
    };
}
