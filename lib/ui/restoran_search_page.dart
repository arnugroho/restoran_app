import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app_dicoding/common/enum_data.dart';
import 'package:restoran_app_dicoding/provider/restaurant_search_provider.dart';
import 'package:restoran_app_dicoding/widgets/card_list_restaurant.dart';
import 'package:restoran_app_dicoding/widgets/platform_widget.dart';

class RestoranSearchPage extends StatelessWidget {
  static const String title = 'List';
  static const routeName = '/restoran_search';

  Widget _buildList() {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return Column(
            children: [
              TextButton.icon(
                onPressed: () {
                  print('Received click');
                },
                icon:
                    Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search),
                label: Text('Search'),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result.restaurants[index];
                    return CardListRestaurant(restoran: restaurant);
                  },
                ),
              )
            ],
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant App'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Restaurant App'),
        transitionBetweenRoutes: false,
      ),
      child: SafeArea(child: _buildList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
