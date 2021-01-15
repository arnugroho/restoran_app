import 'package:flutter/material.dart';
import 'package:restoran_app_dicoding/common/styles.dart';
import 'package:restoran_app_dicoding/data/api/api_service.dart';
import 'package:restoran_app_dicoding/data/model/name_value.dart';
import 'package:restoran_app_dicoding/data/model/restoran.dart';

class DetailRestaurantWidget extends StatelessWidget {
  final Restaurant restoran;

  const DetailRestaurantWidget({Key key, @required this.restoran})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                  tag: restoran.pictureId,
                  child: Image.network(
                      ApiService.pathMediumImg(restoran.pictureId))),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restoran.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.add_location, size: 14),
                            ),
                            TextSpan(text: restoran.city),
                          ],
                        ),
                      ),
                    ),
                    Text(restoran.description),
                    Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(text: 'Foods'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restoran.menus.foods.length,
                        itemBuilder: (context, index) {
                          return _buildFoodsItem(
                              context, restoran.menus.foods[index]);
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(text: 'Drinks'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: restoran.menus.drinks.length,
                        itemBuilder: (context, index) {
                          return _buildDrinksItem(
                              context, restoran.menus.drinks[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
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
