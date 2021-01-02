import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restoran_app_dicoding/common/enum_data.dart';
import 'package:restoran_app_dicoding/data/api/api_service.dart';
import 'package:restoran_app_dicoding/data/model/restoran.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  String query;

  RestaurantSearchProvider({@required this.apiService, @required this.query}) {}

  RestaurantsList _restaurantList;
  String _message = '';
  ResultState _state;

  String get message => _message;

  RestaurantsList get result => _restaurantList;

  ResultState get state => _state;

  loadRestaurantData(query) {
    this.query = query;
    _fetchAllRestaurant();
  }

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.restaurantsListSearch(query);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantList = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
