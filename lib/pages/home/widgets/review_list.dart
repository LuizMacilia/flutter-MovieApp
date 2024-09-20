import 'package:flutter/widgets.dart';
import 'package:movie_app/models/review_model.dart';
import 'package:movie_app/pages/home/widgets/review_item.dart';

class ReviewList extends StatelessWidget {
  final ReviewResult reviews;

  const ReviewList({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        height: size.height * 0.95,
        child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              final review = reviews.reviews[index];
              return ReviewItem(review: review);
            }));
  }
}
