// To parse this JSON data, do
//
//     final cursoforo = cursoforoFromJson(jsonString);

import 'dart:convert';

class CursoForoModel {
  List<Cursoforo> items = [];
  CursoForoModel();
  List<Cursoforo> fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return items;
    for (var item in jsonList) {
      final rItems = Cursoforo.fromJson(item);
      items.add(rItems);
    }
    return items;
  }
}

List<Cursoforo> cursoforoFromJson(String str) => List<Cursoforo>.from(json.decode(str).map((x) => Cursoforo.fromJson(x)));

String cursoforoToJson(List<Cursoforo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cursoforo {
  Cursoforo({
    this.id,
    this.course,
    this.name,
  });

  int? id;
  int? course;
  String? name;

  factory Cursoforo.fromJson(Map<String, dynamic> json) => Cursoforo(
    id: json["id"],
    course: json["course"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "course": course,
    "name": name,
  };
}
