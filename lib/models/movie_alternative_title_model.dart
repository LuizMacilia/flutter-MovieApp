import 'dart:convert';

class MovieAlternativeTitleModel {
   int id;
   List<Titles> alternativeTitles;

  MovieAlternativeTitleModel({
    required this.id,
    required this.alternativeTitles,
  });

  factory MovieAlternativeTitleModel.fromRawJson(String str) =>
      MovieAlternativeTitleModel.fromJson(json.decode(str));

  factory MovieAlternativeTitleModel.fromJson(Map<String, dynamic> json) =>
      MovieAlternativeTitleModel(
        alternativeTitles: List<Titles>.from(json["titles"].map((x) => Titles.fromJson(x))),
        id: json["id"] ?? [],
      );
}

class Titles {
  final String iso31661;
  final String title;
  final String type;


  Titles({
    required this.iso31661,
    required this.title,
    required this.type,
  });

  factory Titles.fromRawJson(String str) => Titles.fromJson(json.decode(str));

  factory Titles.fromJson(Map<String, dynamic> json) => Titles(
        iso31661: json["iso_3166_1"] ?? 0,
        title: json["title"] ?? '',
        type: json["type"] ?? '',
      );
}

