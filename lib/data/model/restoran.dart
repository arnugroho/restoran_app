import 'dart:convert';

import 'package:restoran_app_dicoding/data/model/menus.dart';

class Restoran {
  String id, name, description, pictureId, city;
  num rating;
  Menus menus;

  Restoran(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.menus});

  Restoran.fromJson(Map<String, dynamic> restoran) {
    id = restoran['id'];
    name = restoran['name'];
    description = restoran['description'];
    pictureId = restoran['pictureId'];
    city = restoran['city'];
    rating = restoran['rating'];
    menus =
        restoran['menus'] != null ? Menus.fromJson(restoran['menus']) : null;
  }
}

List<Restoran> parseArticles(String json) {
  if (json == null) {
    return [];
  }
  final Map<String, dynamic> restorants = jsonDecode(json);
  return restorants['restaurants']
      .map<Restoran>((json) => Restoran.fromJson(json))
      .toList();
}

// Model untuk list restorants
class RestaurantsList {
  RestaurantsList({this.error, this.message, this.count, this.restaurants});

  bool error;
  String message;
  int count;
  List<Restoran> restaurants;

  factory RestaurantsList.fromJson(Map<String, dynamic> json) =>
      RestaurantsList(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restoran>.from(
            json["restaurants"].map((x) => Restoran.fromJson(x))),
      );
}

// Model untuk detail restorants
class RestaurantDetail {
  bool error;
  String message;
  int count;
  Restoran restaurant;

  RestaurantDetail({this.error, this.message, this.count, this.restaurant});

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
          error: json["error"],
          message: json["message"],
          count: json["count"],
          restaurant: Restoran.fromJson(json["restaurant"]));
}
