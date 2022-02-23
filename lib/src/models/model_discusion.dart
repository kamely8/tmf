// To parse this JSON data, do
//
//     final discusion = discusionFromJson(jsonString);

import 'dart:convert';


class DiscusionModel {
  List<Discussion> items = [];
  DiscusionModel();
  List<Discussion> fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return items;
    for (var item in jsonList) {
      final rItems = Discussion.fromJson(item);
      items.add(rItems);
    }
    return items;
  }
}


Discussion discusionFromJson(String str) => Discussion.fromJson(json.decode(str));

String discusionToJson(Discussion data) => json.encode(data.toJson());


class Discussion {
  Discussion({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Discussion.fromJson(Map<String, dynamic> json) => Discussion(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
