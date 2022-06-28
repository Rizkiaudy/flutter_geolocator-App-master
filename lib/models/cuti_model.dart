// To parse this JSON data, do
//
//     final cutiModel = cutiModelFromJson(jsonString);

import 'dart:convert';

CutiModel cutiModelFromJson(String str) => CutiModel.fromJson(json.decode(str));

String cutiModelToJson(CutiModel data) => json.encode(data.toJson());

class CutiModel {
    CutiModel({
        required this.status,
        required this.msg,
        this.errors,
        required this.content,
    });

    String status;
    String msg;
    dynamic errors;
    Content content;

    factory CutiModel.fromJson(Map<String, dynamic> json) => CutiModel(
        status: json["status"],
        msg: json["msg"],
        errors: json["errors"],
        content: Content.fromJson(json["content"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "errors": errors,
        "content": content.toJson(),
    };
}

class Content {
    Content({
        required this.statusCode,
    });

    int statusCode;

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        statusCode: json["status_code"],
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode,
    };
}
