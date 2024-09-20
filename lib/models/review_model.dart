import 'dart:convert';

class ReviewResult {
  List<Review> reviews;

  ReviewResult({required this.reviews});

  factory ReviewResult.fromRawJson(String str) =>
      ReviewResult.fromJson(json.decode(str));

  factory ReviewResult.fromJson(Map<String, dynamic> json) => ReviewResult(
      reviews:
          List<Review>.from(json["results"].map((x) => Review.fromJson(x))));
}

class Review {
  String author;
  String content;
  String updatedAt;

  Review(
      {required this.author, required this.content, required this.updatedAt});

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  factory Review.fromJson(Map<String, dynamic> json) => Review(
      author: json["author"],
      content: json["content"],
      updatedAt: json["updated_at"]);
}
