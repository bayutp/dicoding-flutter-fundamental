import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/provider/detail/restaurant_detail_provider.dart';
import 'package:tourism_app/screen/main/restaurant_rating_widget.dart';
import 'package:tourism_app/static/restaurant_detail_result_state.dart';
import 'package:tourism_app/static/restaurant_list_result_state.dart';
import 'package:tourism_app/style/colors/restaurant_colors.dart';

class DetailScreen extends StatefulWidget {
  final String id;
  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    final provider = context.read<RestaurantDetailProvider>();
    Future.microtask(() {
      provider.getRestaurantDetail(widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            RestaurantDetailLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            RestaurantDetailLoadedState(data: var restaurant) => Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RestaurantRatingWidget(rating: restaurant.rating),
                          SizedBox.square(dimension: 10),
                          Text(
                            '${restaurant.customerReviews.length.toString()} Reviews',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: RestaurantColors.grey.colors),
                          ),
                        ],
                      ),
                      SizedBox(width: 24),
                      SizedBox(
                        height: 50,
                        child: VerticalDivider(
                          width: 1, // lebar area divider
                          thickness: 2, // tebal garis
                          color: Colors.grey[200],
                          indent: 2,
                          endIndent: 2,
                        ),
                      ),
                      SizedBox(width: 24),
                      Icon(
                        Icons.place_rounded,
                        color: RestaurantColors.grey.colors,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        // biar teks alamat gak overflow
                        child: Text(
                          '${restaurant.address}, ${restaurant.city}',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: RestaurantColors.address.colors,
                              ),
                          overflow: TextOverflow
                              .ellipsis, // kasih titik2 kalau kepanjangan
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            RestaurantListErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => SizedBox(),
          };
        },
      ),
    );
  }
}
