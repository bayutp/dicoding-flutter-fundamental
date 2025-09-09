import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tourism_app/provider/detail/restaurant_detail_provider.dart';
import 'package:tourism_app/screen/detail/menu_restaurant_widget.dart';
import 'package:tourism_app/static/helper.dart';
import 'package:tourism_app/screen/home/restaurant_rating_widget.dart';
import 'package:tourism_app/static/navigation_route.dart';
import 'package:tourism_app/static/restaurant_detail_result_state.dart';
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
    super.initState();

    final provider = context.read<RestaurantDetailProvider>();
    Future.microtask(() {
      provider.getRestaurantDetail(widget.id);
    });
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
            RestaurantDetailLoadedState(data: var restaurant) =>
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: restaurant.id,
                      child: Image.network(
                        Helper.imgUrl(restaurant.pictureId, 'large'),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox.square(dimension: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36.0,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                restaurant.name,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineLarge,
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.favorite_border),
                            ],
                          ),
                          SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  RestaurantRatingWidget(
                                    rating: restaurant.rating,
                                  ),
                                  SizedBox.square(dimension: 10),
                                  Text(
                                    '${restaurant.customerReviews.length.toString()} Reviews',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: RestaurantColors.grey.colors,
                                        ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 24),
                              SizedBox(
                                height: 60,
                                child: VerticalDivider(
                                  width: 1, // lebar area divider
                                  thickness: 2, // tebal garis
                                  color: Colors.grey[200],
                                  indent: 2,
                                  endIndent: 2,
                                ),
                              ),
                              SizedBox(width: 24),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.place_rounded,
                                          color: RestaurantColors.grey.colors,
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            '${restaurant.address}, ${restaurant.city}',
                                            softWrap: true,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: RestaurantColors
                                                      .address
                                                      .colors,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.label_important_rounded,
                                          color: RestaurantColors.grey.colors,
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            restaurant.categories
                                                .map((item) => item.name)
                                                .join(", "),
                                            softWrap: true,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: RestaurantColors
                                                      .grey
                                                      .colors,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox.square(dimension: 24),
                          SizedBox(
                            height: 48,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  RestaurantColors.amber.colors,
                                ),
                                foregroundColor: WidgetStateProperty.all(
                                  RestaurantColors.white.colors,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  NavigationRoute.reviewRoute.name,
                                  arguments: restaurant,
                                );
                              },
                              child: Text(
                                'Add Review',
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox.square(dimension: 32),
                          Text(
                            restaurant.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          SizedBox.square(dimension: 32),
                          MenuRestaurantWidget(restaurant: restaurant),
                          SizedBox.square(dimension: 32),
                          Text(
                            'Customer Review',
                            style: Theme.of(
                              context,
                            ).textTheme.headlineLarge?.copyWith(fontSize: 24),
                          ),
                          SizedBox.square(dimension: 16),
                          ListView.builder(
                            shrinkWrap: true,
                            reverse: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: restaurant.customerReviews.length,
                            itemBuilder: (context, index) {
                              final item = restaurant.customerReviews[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusGeometry.circular(
                                    30,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 30,
                                      backgroundColor:
                                          RestaurantColors.grey.colors,
                                      child: Icon(
                                        Icons.person_2_rounded,
                                        color: RestaurantColors.white.colors,
                                      ),
                                    ),
                                    title: Text('${item.name}\n${item.review}'),
                                    trailing: const Icon(Icons.more_horiz),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            RestaurantDetailErrorState(error: var message) => Center(
              child: Text(message),
            ),
            _ => SizedBox(),
          };
        },
      ),
    );
  }
}
