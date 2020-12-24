import 'dart:convert';

import 'package:restoran_app_dicoding/data/model/menus.dart';

class Restoran {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  num rating;
  Menus menus;

  Restoran(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.rating,
      this.menus
      });

  Restoran.fromJson(Map<String, dynamic> restoran) {
    id = restoran['id'];
    name = restoran['name'];
    description = restoran['description'];
    pictureId = restoran['pictureId'];
    city = restoran['city'];
    rating = restoran['rating'];
    menus = restoran['menus'] != null ? Menus.fromJson(restoran['menus']) : null;
  }
}

List<Restoran> parseArticles(String json) {
  if (json == null) {
    return [];
  }


  final Map<String, dynamic> restorants = jsonDecode(json);
//  final List parsed = restorants.values;
  return restorants['restaurants'].map<Restoran>((json) => Restoran.fromJson(json)).toList();
  return null;
}