import 'dart:convert';

class MovieAlternativeTitleModel {
  int id;
  List<Titles> alternativeTitles;

  MovieAlternativeTitleModel(
      {required this.id, required this.alternativeTitles});

  factory MovieAlternativeTitleModel.fromRawJson(String str) =>
      MovieAlternativeTitleModel.fromJson(json.decode(str));

  factory MovieAlternativeTitleModel.fromJson(Map<String, dynamic> json) =>
      MovieAlternativeTitleModel(
        id: json["id"] ?? 0,
        alternativeTitles:
            List<Titles>.from(json["titles"].map((x) => Titles.fromJson(x))),
      );
}

class Titles {
  int id;
  String title;

  Titles({required this.id, required this.title});

  factory Titles.fromRawJson(String str) => Titles.fromJson(json.decode(str));

  factory Titles.fromJson(Map<String, dynamic> json) => Titles(
        id: json["id"] ?? 0,
        title: json["title"] ?? '',
      );
}
