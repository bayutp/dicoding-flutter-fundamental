import 'package:tourism_app/data/model/category.dart';
import 'package:tourism_app/data/model/customer_review.dart';
import 'package:tourism_app/data/model/menus.dart';
import 'package:tourism_app/data/model/restaurant.dart';

class RestaurantDetail extends Restaurant {
  String address;
  List<Category> categories;
  Menus menus;
  List<CustomerReview> customerReviews;

  RestaurantDetail({
    required super.id,
    required super.name,
    required super.description,
    required super.pictureId,
    required super.city,
    required super.rating,
    required this.address,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(
          json["categories"].map((x) => Category.fromJson(x)),
        ),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"],
        customerReviews: List<CustomerReview>.from(
          json["customerReviews"].map((x) => CustomerReview.fromJson(x)),
        ),
      );
}
