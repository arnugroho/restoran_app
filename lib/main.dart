import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app_dicoding/data/api/api_service.dart';
import 'package:restoran_app_dicoding/data/db/database_helper.dart';
import 'package:restoran_app_dicoding/data/preferences/preferences_helper.dart';
import 'package:restoran_app_dicoding/provider/database_provider.dart';
import 'package:restoran_app_dicoding/provider/preferences_provider.dart';
import 'package:restoran_app_dicoding/provider/restaurant_detail_provider.dart';
import 'package:restoran_app_dicoding/provider/restaurant_search_provider.dart';
import 'package:restoran_app_dicoding/provider/scheduling_provider.dart';
import 'package:restoran_app_dicoding/splash.dart';
import 'package:restoran_app_dicoding/ui/detail_restaurant_page.dart';
import 'package:restoran_app_dicoding/ui/restaurant_list_page.dart';
import 'package:restoran_app_dicoding/ui/restaurant_search_page.dart';
import 'package:restoran_app_dicoding/utils/background_service.dart';
import 'package:restoran_app_dicoding/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Restoran App',
            theme: provider.themeData,
            initialRoute: SplashScreen.routeName,
            routes: {
              SplashScreen.routeName: (context) => SplashScreen(),
              RestaurantListPage.routeName: (context) => RestaurantListPage(),
              RestaurantDetailPage.routeName: (context) =>
                  ChangeNotifierProvider<RestaurantDetailProvider>(
                    create: (_) => RestaurantDetailProvider(
                        apiService: ApiService(),
                        idRestaurant:
                        ModalRoute.of(context).settings.arguments),
                    child: RestaurantDetailPage(),
                  ),
              RestaurantSearchPage.routeName: (context) =>
                  ChangeNotifierProvider<RestaurantSearchProvider>(
                    create: (_) => RestaurantSearchProvider(
                        apiService: ApiService(), query: ''),
                    child: RestaurantSearchPage(),
                  )
            },
          );
        },
      ),
    );
  }
}
