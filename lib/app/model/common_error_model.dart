// To parse this JSON data, do
//
//     final commonErrorModel = commonErrorModelFromJson(jsonString);

import 'dart:convert';

CommonErrorModel commonErrorModelFromJson(String str) => CommonErrorModel.fromJson(json.decode(str));

String commonErrorModelToJson(CommonErrorModel data) => json.encode(data.toJson());

class CommonErrorModel {
    CommonErrorModel({
        this.name,
        this.message,
        
    });

    String? name;
    String? message;
   

    factory CommonErrorModel.fromJson(Map<String, dynamic> json) => CommonErrorModel(
        name: json["name"] == null ? null : json["name"],
        message: json["message"] == null ? null : json["message"],
      
    );

    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "message": message == null ? null : message,
       
    };
}
