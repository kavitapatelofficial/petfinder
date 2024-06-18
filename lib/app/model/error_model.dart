// To parse this JSON data, do
//
//     final errorModel = errorModelFromJson(jsonString);

import 'dart:convert';

ErrorModel errorModelFromJson(String str) =>
    ErrorModel.fromJson(json.decode(str));

String errorModelToJson(ErrorModel data) => json.encode(data.toJson());

class ErrorModel {
  ErrorModel({
    this.errors,
  });

  List<Error>? errors;

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        errors: json["errors"] == null
            ? null
            : List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "errors": errors == null
            ? null
            : List<dynamic>.from(errors!.map((x) => x.toJson())),
      };
}

class Error {
  Error({
    this.code,
    this.message,
  });

  String? code;
  String? message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
      };
}
