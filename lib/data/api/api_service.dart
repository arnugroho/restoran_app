import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restoran_app_dicoding/data/model/restoran.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantsList> restaurantsList() async {
    final response = await http.get(_baseUrl + "list");
    if (response.statusCode == 200) {
      return RestaurantsList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  static String pathSmallImg(url) {
    return _baseUrl + 'images/small/' + url;
  }

  Future<RestaurantDetail> restaurantsDetail(idRestaurant) async {
    final response = await http.get(_baseUrl + "detail/" + idRestaurant);
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }
}
