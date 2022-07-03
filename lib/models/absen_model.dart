// To parse this JSON data, do
//
//     final absenModel = absenModelFromJson(jsonString);

import 'dart:convert';

AbsenModel absenModelFromJson(String str) =>
    AbsenModel.fromJson(json.decode(str));

String absenModelToJson(AbsenModel data) => json.encode(data.toJson());

class AbsenModel {
  AbsenModel({
    this.status,
    this.msg,
    this.errors,
    this.content,
  });

  String? status;
  String? msg;
  String? errors;
  List<Content>? content;

  factory AbsenModel.fromJson(Map<String, dynamic> json) => AbsenModel(
        status: json["status"],
        msg: json["msg"],
        errors: json["errors"],
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "errors": errors,
        "content": List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

class Content {
  Content({
    this.id,
    this.user,
    this.tanggal,
    this.jamDatang,
    this.jamDatangJadwal,
    this.terlambat,
    this.jamPulang,
  });
  final int? id;
  final String? user;
  final DateTime? tanggal;
  final String? jamDatang;
  final String? jamPulang;
  final String? jamDatangJadwal;
  final bool? terlambat;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
      id: json["id"],
      user: json["user"],
      tanggal: DateTime.parse(json["tanggal"]),
      jamDatang: json["jam_datang"],
      jamDatangJadwal: json["jam_datang_jadwal"],
      terlambat: json["terlambat"],
      jamPulang: json['jam_pulang']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "tanggal":
            "${tanggal!.year.toString().padLeft(4, '0')}-${tanggal!.month.toString().padLeft(2, '0')}-${tanggal!.day.toString().padLeft(2, '0')}",
        "jam_datang": jamDatang,
        "jam_datang_jadwal": jamDatangJadwal,
        "terlambat": terlambat,
        "jam_pulang": jamPulang,
      };
}
