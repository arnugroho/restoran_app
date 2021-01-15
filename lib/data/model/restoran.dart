import 'dart:convert';

import 'package:restoran_app_dicoding/data/model/menus.dart';

class Restaurant {
  String id, name, description, pictureId, city;
  num rating;
  Menus menus;

  Restaurant(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.menus});

  Restaurant.fromJson(Map<String, dynamic> restaurant) {
    id = restaurant['id'];
    name = restaurant['name'];
    description = restaurant['description'];
    pictureId = restaurant['pictureId'];
    city = restaurant['city'];
    rating = restaurant['rating'];
    menus = restaurant['menus'] != null
        ? Menus.fromJson(restaurant['menus'])
        : null;
  }
}

List<Restaurant> parseArticles(String json) {
  if (json == null) {
    return [];
  }
  final Map<String, dynamic> restorants = jsonDecode(json);
  return restorants['restaurants']
      .map<Restaurant>((json) => Restaurant.fromJson(json))
      .toList();
}

// Model untuk list restorants
class RestaurantsList {
  RestaurantsList({this.error, this.message, this.count, this.restaurants});

  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  factory RestaurantsList.fromJson(Map<String, dynamic> json) =>
      RestaurantsList(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}

// Model untuk detail restorants
class RestaurantDetail {
  bool error;
  String message;
  int count;
  Restaurant restaurant;

  RestaurantDetail({this.error, this.message, this.count, this.restaurant});

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
          error: json["error"],
          message: json["message"],
          count: json["count"],
          restaurant: Restaurant.fromJson(json["restaurant"]));
}
