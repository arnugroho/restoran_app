import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app_dicoding/common/styles.dart';
import 'package:restoran_app_dicoding/data/api/api_service.dart';
import 'package:restoran_app_dicoding/provider/restaurant_detail_provider.dart';
import 'package:restoran_app_dicoding/splash.dart';
import 'package:restoran_app_dicoding/ui/detail_restoran_page.dart';
import 'package:restoran_app_dicoding/ui/restoran_list_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restoran App',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        RestoranListPage.routeName: (context) => RestoranListPage(),
        // RestoranDetailPage.routeName: (context) => RestoranDetailPage(
        //   idRestaurant: ModalRoute.of(context).settings.arguments,
        // ),
        RestoranDetailPage.routeName: (context) =>
            ChangeNotifierProvider<RestaurantDetailProvider>(
              create: (_) => RestaurantDetailProvider(
                  apiService: ApiService(),
                  idRestaurant: ModalRoute.of(context).settings.arguments),
              child: RestoranDetailPage(),
            )
      },
    );
  }
}