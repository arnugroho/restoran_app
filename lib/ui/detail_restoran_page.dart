import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app_dicoding/common/enum_data.dart';
import 'package:restoran_app_dicoding/data/model/name_value.dart';
import 'package:restoran_app_dicoding/provider/restaurant_detail_provider.dart';
import 'package:restoran_app_dicoding/widgets/platform_widget.dart';

class RestoranDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  Widget _buildList() {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return Text('data');
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
        title: Text('Restaurant'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Restaurant'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(
//       title: Text(restoran.name),
//     ),
//     body: SingleChildScrollView(
//       child: Column(
//         children: [
//           Hero(
//               tag: restoran.pictureId,
//               child: Image.network(restoran.pictureId)),
//           Padding(
//             padding: EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   restoran.name,
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 24,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: RichText(
//                     text: TextSpan(
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                       children: [
//                         WidgetSpan(
//                           child: Icon(Icons.add_location, size: 14),
//                         ),
//                         TextSpan(text: restoran.city),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Text(restoran.description),
//                 Divider(color: Colors.grey),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: RichText(
//                     text: TextSpan(
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                       children: [
//                         TextSpan(text: 'Foods'),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: restoran.menus.foods.length,
//                     itemBuilder: (context, index) {
//                       return _buildFoodsItem(
//                           context, restoran.menus.foods[index]);
//                     },
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: RichText(
//                     text: TextSpan(
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                       children: [
//                         TextSpan(text: 'Drinks'),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 50,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: restoran.menus.drinks.length,
//                     itemBuilder: (context, index) {
//                       return _buildDrinksItem(
//                           context, restoran.menus.drinks[index]);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}

Widget _buildFoodsItem(BuildContext context, NameValue nameValue) {
  return Card(
      child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(child: (Text(nameValue.name))),
  ));
}

Widget _buildDrinksItem(BuildContext context, NameValue nameValue) {
  return Card(
      child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(child: (Text(nameValue.name))),
  ));
}
