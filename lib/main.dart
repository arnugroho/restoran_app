import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app_dicoding/common/styles.dart';
import 'package:restoran_app_dicoding/data/api/api_service.dart';
import 'package:restoran_app_dicoding/provider/restaurant_detail_provider.dart';
import 'package:restoran_app_dicoding/provider/restaurant_search_provider.dart';
import 'package:restoran_app_dicoding/splash.dart';
import 'package:restoran_app_dicoding/ui/detail_restaurant_page.dart';
import 'package:restoran_app_dicoding/ui/restaurant_list_page.dart';
import 'package:restoran_app_dicoding/ui/restaurant_search_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restoran App',
      theme: buildTheme(),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        RestaurantListPage.routeName: (context) => RestaurantListPage(),
        RestaurantDetailPage.routeName: (context) =>
            ChangeNotifierProvider<RestaurantDetailProvider>(
              create: (_) => RestaurantDetailProvider(
                  apiService: ApiService(),
                  idRestaurant: ModalRoute.of(context).settings.arguments),
              child: RestaurantDetailPage(),
            ),
        RestaurantSearchPage.routeName: (context) =>
            ChangeNotifierProvider<RestaurantSearchProvider>(
              create: (_) =>
                  RestaurantSearchProvider(apiService: ApiService(), query: ''),
              child: RestaurantSearchPage(),
            )
      },
    );
  }
}
