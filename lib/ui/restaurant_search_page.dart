import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app_dicoding/common/enum_data.dart';
import 'package:restoran_app_dicoding/common/styles.dart';
import 'package:restoran_app_dicoding/provider/restaurant_search_provider.dart';
import 'package:restoran_app_dicoding/widgets/card_list_restaurant.dart';
import 'package:restoran_app_dicoding/widgets/platform_widget.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const String title = 'Search Restaurant';
  static const routeName = '/restoran_search';
  TextEditingController _tvQuery = TextEditingController();

  Widget _buildList() {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return Column(
            children: [
              _tfSearchAndroid(context, state),
              _listSearch(context, state)
            ],
          );
        } else if (state.state == ResultState.NoData) {
          return Column(
            children: [
              _tfSearchAndroid(context, state),
              Expanded(
                  child: Column(
                children: [
                  Icon(Icons.search, size: 46),
                  Text(state.message),
                ],
              )),
            ],
          );
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Column(children: [
            _tfSearchAndroid(context, state),
            Expanded(
                //makes the red row full width
                child: Center(
                    child: Icon(
              Icons.search,
              size: 46,
            )))
          ]);
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(child: _buildList()),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(title),
        transitionBetweenRoutes: false,
      ),
      child: SafeArea(child: _buildList()),
    );
  }

  Widget _tfSearchAndroid(BuildContext context, state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _tvQuery,
        autofocus: true,
        onChanged: (text) {
          _onChangeTFSearch(state);
        },
        decoration: InputDecoration(
          labelText: 'Search',
          suffixIcon: Icon(
            Icons.search,
          ),
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
            color: secondaryColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: secondaryColor),
          ),
        ),
      ),
    );
  }

  Widget _listSearch(BuildContext context, state) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.result.restaurants.length,
        itemBuilder: (context, index) {
          var restaurant = state.result.restaurants[index];
          return CardListRestaurant(restoran: restaurant);
        },
      ),
    );
  }

  _onChangeTFSearch(RestaurantSearchProvider state) {
    state.loadRestaurantData(_tvQuery.text);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
