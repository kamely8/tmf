// To parse this JSON data, do
//
//     final postdiscusion = postdiscusionFromJson(jsonString);

import 'dart:convert';

class DiscusionPostModel {
  List<Post> items = [];
  DiscusionPostModel();
  List<Post> fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return items;
    for (var item in jsonList) {
      final rItems = Post.fromJson(item);
      items.add(rItems);
    }
    return items;
  }
}

Post postdiscusionFromJson(String str) => Post.fromJson(json.decode(str));

String postdiscusionToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    this.id,
    this.message,
    this.sentiment
  });

  int? id;
  String? message;
  String? sentiment;


  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "message": message,
    "sentiment": sentiment,
  };
}
