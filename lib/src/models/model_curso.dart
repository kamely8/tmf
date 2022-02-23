// To parse this JSON data, do
//
//     final cursos = cursosFromJson(jsonString);

import 'dart:convert';

class CursosModel {
  List<Cursos> items = [];
  CursosModel();
  List<Cursos> fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return items;
    for (var item in jsonList) {
      final rItems = Cursos.fromJson(item);
      items.add(rItems);
    }
    return items;
  }
}

List<Cursos> cursosFromJson(String str) => List<Cursos>.from(json.decode(str).map((x) => Cursos.fromJson(x)));

String cursosToJson(List<Cursos> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cursos {
  Cursos({
    this.id,
    this.shortname,
  });

  int? id;
  String? shortname;

  factory Cursos.fromJson(Map<String, dynamic> json) => Cursos(
    id: json["id"],
    shortname: json["shortname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shortname": shortname,
  };
}
