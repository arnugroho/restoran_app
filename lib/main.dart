import 'package:flutter/material.dart';
import 'package:restoran_app_dicoding/splash.dart';
import 'package:restoran_app_dicoding/styles.dart';
import 'package:restoran_app_dicoding/ui/restoran_list_page.dart';

import 'ui/detail_restoran.dart';

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
        RestoranDetailPage.routeName: (context) => RestoranDetailPage(
          restoran: ModalRoute.of(context).settings.arguments,
        ),
      },
    );
  }
}