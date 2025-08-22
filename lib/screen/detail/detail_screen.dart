import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/provider/detail/restaurant_detail_provider.dart';
import 'package:tourism_app/static/restaurant_detail_result_state.dart';
import 'package:tourism_app/static/restaurant_list_result_state.dart';

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
            RestaurantDetailLoadedState(data: var restaurant) => Center(
              child: Column(
                children: [
                  Image.network(
                    "https://restaurant-api.dicoding.dev/images/large/${restaurant.pictureId}",
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16,),
                  Text(restaurant.name),
                  SizedBox(height: 8),
                  Text(restaurant.city),
                  SizedBox(height: 16),
                  Text(restaurant.description),
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
