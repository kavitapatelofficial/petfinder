// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) => MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
    MessageModel({
        this.message,
        this.success,
    });

    String? message;
    bool? success;

    factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json["message"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "success": success,
    };
}
