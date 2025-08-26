import 'package:flutter/material.dart';
import 'package:tourism_app/data/model/restaurant.dart';
import 'package:tourism_app/screen/home/helper.dart';
import 'package:tourism_app/screen/home/restaurant_rating_widget.dart';
import 'package:tourism_app/style/colors/restaurant_colors.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;
  const RestaurantItem({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 130,
                maxWidth: 100,
                minHeight: 130,
                minWidth: 100,
              ),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Image.network(
                  Helper.imgUrl(restaurant.pictureId, 'medium'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox.square(dimension: 16),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox.square(dimension: 8),
                  RestaurantRatingWidget(rating: restaurant.rating),
                  SizedBox.square(dimension: 32),
                  Row(
                    children: [
                      Icon(
                        Icons.place_rounded,
                        color: RestaurantColors.grey.colors,
                      ),
                      SizedBox(width: 8),
                      Text(
                        restaurant.city,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
