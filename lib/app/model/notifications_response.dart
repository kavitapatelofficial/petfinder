// To parse this JSON data, do
//
//     final notificationsResposeModel = notificationsResposeModelFromJson(jsonString);

import 'dart:convert';

NotificationsResposeModel notificationsResposeModelFromJson(String str) => NotificationsResposeModel.fromJson(json.decode(str));

String notificationsResposeModelToJson(NotificationsResposeModel data) => json.encode(data.toJson());

class NotificationsResposeModel {
    NotificationsResposeModel({
        this.result,
        this.message,
        this.success,
    });

    Result? result;
    String? message;
    bool? success;

    factory NotificationsResposeModel.fromJson(Map<String, dynamic> json) => NotificationsResposeModel(
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
        message: json["message"] == null ? null : json["message"],
        success: json["success"] == null ? null : json["success"],
    );

    Map<String, dynamic> toJson() => {
        "result": result == null ? null : result!.toJson(),
        "message": message == null ? null : message,
        "success": success == null ? null : success,
    };
}

class Result {
    Result({
        this.id,
        this.user,
        this.notifications,
        this.count,
    });

    String? id;
    String? user;
    List<Notification>? notifications;
    int? count;

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : json["user"],
        notifications: json["notifications"] == null ? null : List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
        count: json["count"] == null ? null : json["count"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user": user == null ? null : user,
        "notifications": notifications == null ? null : List<dynamic>.from(notifications!.map((x) => x.toJson())),
        "count": count == null ? null : count,
    };
}

class Notification {
    Notification({
        this.title,
        this.description,
        this.seen,
      
        this.name,
    });

    String? title;
    String? description;
    bool? seen;
   
   
    String? name;

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        seen: json["seen"] == null ? null : json["seen"],
       
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "seen": seen == null ? null : seen,
       
        "name": name == null ? null : name,
    };
}
