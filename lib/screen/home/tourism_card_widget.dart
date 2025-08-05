import 'package:flutter/material.dart';
import 'package:tourism_app/model/tourism.dart';

class TourismCard extends StatelessWidget {
  const TourismCard({super.key, required this.tourism, required this.onTap});

  final Tourism tourism;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 100,
                maxWidth: 150,
                minHeight: 100,
                minWidth: 150,
              ),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.only(
                  topLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                child: Hero(
                  tag: tourism.image,
                  child: Image.network(tourism.image, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox.square(dimension: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tourism.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox.square(dimension: 6),
                  Row(
                    children: [
                      Icon(Icons.pin_drop_sharp, color: Colors.lightBlue),
                      Expanded(
                        child: Text(
                          tourism.address,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox.square(dimension: 6),
                  Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.red),
                      Expanded(
                        child: Text(
                          tourism.like.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
