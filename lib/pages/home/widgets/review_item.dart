import 'package:flutter/material.dart';
import 'package:movie_app/models/review_model.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    super.key,
    required this.review,
  });

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("User: ${review.author}",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 15)),
            const Spacer(flex: 40),
            Text("Date: ${review.updatedAt}",
                style: const TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 12))
          ],
        ),
        Text(review.content,
            style: const TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.w300,
                fontSize: 12)),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
