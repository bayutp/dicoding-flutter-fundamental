import 'package:flutter/material.dart';
import 'package:tourism_app/data/model/restaurant_detail.dart';

class MenuRestaurantWidget extends StatefulWidget {
  final RestaurantDetail restaurant;
  const MenuRestaurantWidget({super.key, required this.restaurant});

  @override
  State<MenuRestaurantWidget> createState() => _MenuRestaurantWidgetState();
}

class _MenuRestaurantWidgetState extends State<MenuRestaurantWidget> {
  String selectedCategory = "foods";
  @override
  Widget build(BuildContext context) {
    final menus = widget.restaurant.menus;
    final items = selectedCategory == "foods" ? menus.foods : menus.drinks;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Menu',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(fontSize: 24),
        ),
        SizedBox.square(dimension: 16),
        Wrap(
          spacing: 8,
          children: ["foods", "drinks"].map((category) {
            return ChoiceChip(
              label: Text(category),
              selected: selectedCategory == category,
              onSelected: (_) {
                setState(() {
                  selectedCategory = category;
                });
              },
            );
          }).toList(),
        ),
        const SizedBox.square(dimension: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: Icon(Icons.fastfood_rounded),
                  title: Text(item.name),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
