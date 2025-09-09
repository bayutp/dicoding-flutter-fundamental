import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/data/model/restaurant_detail.dart';
import 'package:tourism_app/provider/detail/category_provider.dart';

class MenuRestaurantWidget extends StatefulWidget {
  final RestaurantDetail restaurant;
  const MenuRestaurantWidget({super.key, required this.restaurant});

  @override
  State<MenuRestaurantWidget> createState() => _MenuRestaurantWidgetState();
}

class _MenuRestaurantWidgetState extends State<MenuRestaurantWidget> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    
    CategoryProvider provider = context.read<CategoryProvider>();
    provider.setCategory = "foods";
    Future.microtask(() {
      selectedCategory = provider.selectedCategory;
    });
  }

  @override
  Widget build(BuildContext context) {
    context.watch<CategoryProvider>();
    final menus = widget.restaurant.menus;

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
        Consumer<CategoryProvider>(
          builder: (context, value, child) {
            return Wrap(
              spacing: 8,
              children: ["foods", "drinks"].map((category) {
                return ChoiceChip(
                  label: Text(category),
                  selected: value.selectedCategory == category,
                  onSelected: (_) {
                    value.setCategory = category;
                  },
                );
              }).toList(),
            );
          },
        ),
        const SizedBox.square(dimension: 16),
        Consumer<CategoryProvider>(
          builder: (context, value, child) {
            final items = value.selectedCategory == "foods"
                ? menus.foods
                : menus.drinks;
            return ListView.builder(
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
            );
          },
        ),
      ],
    );
  }
}
