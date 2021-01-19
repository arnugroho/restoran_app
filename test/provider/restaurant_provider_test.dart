import 'package:flutter_test/flutter_test.dart';
import 'package:restoran_app_dicoding/data/api/api_service.dart';
import 'package:restoran_app_dicoding/data/model/restaurant.dart';
import 'package:restoran_app_dicoding/provider/restaurant_provider.dart';

void main() {
  test('Test Get Restaurant List', () async {
    // arrange
    var restaurantProvider = RestaurantProvider(apiService: ApiService());
    RestaurantsList restaurantList =
        await restaurantProvider.fetchAllRestaurant();
    var testModuleName = 'success';
    // assert

    var result = restaurantList.message.contains(testModuleName);
    expect(result, true);
  });
}
