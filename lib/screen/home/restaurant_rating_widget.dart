import 'package:flutter/material.dart';
import 'package:tourism_app/style/colors/restaurant_colors.dart';

class RestaurantRatingWidget extends StatelessWidget {
  final double rating;
  const RestaurantRatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(5, (index) {
            if (index < rating.floor()) {
              return Icon(Icons.star, color: RestaurantColors.amber.colors);
            } else if (index < rating && rating % 1 != 0) {
              return Icon(
                Icons.star_half,
                color: RestaurantColors.amber.colors,
              );
            } else {
              return Icon(
                Icons.star_border,
                color: RestaurantColors.amber.colors,
              );
            }
          }),
        ),
        SizedBox(width: 8),
        Text(
          rating.toString(),
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
