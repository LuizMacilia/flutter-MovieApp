import 'dart:convert';

class ReviewResult {
  int movieId;
  int page; 
  List<dynamic> reviews; 

  ReviewResult({
    required this.movieId,
    required this.page,
    required this.reviews
  });

  factory ReviewResult.fromRawJson(String str) => ReviewResult.fromJson(json.decode(str));

  factory ReviewResult.fromJson(Map<String, dynamic> json) => ReviewResult(
    movieId: json["id"],
    page: json["page"],
    reviews: json["results"]
  );

}


class Review {
  String author;
  String content;
  String updatedAt;

  Review({
    required this.author,
    required this.content,
    required this.updatedAt
  });

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    author: json["author"],
    content: json["content"],
    updatedAt: json["updated_at"]
  );


}