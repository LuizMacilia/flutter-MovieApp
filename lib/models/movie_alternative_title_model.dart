import 'dart:convert';

class MovieAlternativeTitleModel {
  final int id;
  final List<Titles> alternativeTitles;

  MovieAlternativeTitleModel({
    required this.id,
    required this.alternativeTitles,
  });

  factory MovieAlternativeTitleModel.fromJson(Map<String, dynamic> json) {
    var list = json['titles'] as List;
    List<Titles> titleList = list.map((i) => Titles.fromJson(i)).toList();

    return MovieAlternativeTitleModel(
      id: json['id'] ?? 0, // Garantir que 'id' nunca seja null
      alternativeTitles: titleList, // Mapeamento correto dos títulos
    );
  }
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

  factory Titles.fromJson(Map<String, dynamic> json) {
    return Titles(
      iso31661: json['iso_3166_1'] ?? '', // Tratar iso_3166_1 como String
      title: json['title'] ?? 'Título desconhecido', // Tratar title como String
      type: json['type'] ?? '', // Tratar type como String
    );
  }
}

