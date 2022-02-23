// To parse this JSON data, do
//
//     final sentimiento = sentimientoFromJson(jsonString);

import 'dart:convert';

Sentimiento sentimientoFromJson(String str) => Sentimiento.fromJson(json.decode(str));

String sentimientoToJson(Sentimiento data) => json.encode(data.toJson());

class Sentimiento {
  Sentimiento({
    this.sentiment,
  });

  String? sentiment;

  factory Sentimiento.fromJson(Map<String, dynamic> json) => Sentimiento(
    sentiment: json["sentiment"],
  );

  Map<String, dynamic> toJson() => {
    "sentiment": sentiment,
  };
}
