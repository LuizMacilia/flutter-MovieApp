import 'package:movie_app/models/review_model.dart';
import 'package:movie_app/services/api_services.dart';

void main() {
  ApiServices api = ApiServices();

  Future<ReviewResult> reviews = api.getTopReviewsMovie(100);

  print(reviews);
}