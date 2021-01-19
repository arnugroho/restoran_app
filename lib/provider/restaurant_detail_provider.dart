import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restoran_app_dicoding/common/enum_data.dart';
import 'package:restoran_app_dicoding/data/api/api_service.dart';
import 'package:restoran_app_dicoding/data/model/restaurant.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final idRestaurant;

  RestaurantDetailProvider(
      {@required this.apiService, @required this.idRestaurant}) {
    _fetchRestaurant();
  }

  RestaurantDetail _restaurantDetail;
  String _message = '';
  ResultState _state;

  String get message => _message;

  RestaurantDetail get result => _restaurantDetail;

  ResultState get state => _state;

  Future<dynamic> _fetchRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final _restaurantDetailResult =
          await apiService.restaurantsDetail(idRestaurant);
      if (_restaurantDetailResult == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantDetail = _restaurantDetailResult;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Tidak Ada Koneksi Internet';
    }
  }
}
