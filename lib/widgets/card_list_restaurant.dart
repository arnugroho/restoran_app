import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restoran_app_dicoding/common/styles.dart';
import 'package:restoran_app_dicoding/data/api/api_service.dart';
import 'package:restoran_app_dicoding/data/model/restaurant.dart';
import 'package:restoran_app_dicoding/provider/database_provider.dart';
import 'package:restoran_app_dicoding/ui/detail_restaurant_page.dart';

class CardListRestaurant extends StatelessWidget {
  final Restaurant restoran;

  const CardListRestaurant({Key key, @required this.restoran})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restoran.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              color: primaryColor,
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: restoran.pictureId == null
                    ? Container(width: 100, child: Icon(Icons.error))
                    : Hero(
                        tag: restoran.pictureId,
                        child: Image.network(
                          ApiService.pathSmallImg(restoran.pictureId),
                          width: 100,
                        ),
                      ),
                title: Text(
                  restoran.name ?? "",
                ),
                subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Row(
                                  children: [
                                    Icon(Icons.add_location, size: 14),
                                    Text(restoran.city)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 4),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Row(
                                  children: [
                                    Icon(Icons.star, size: 14),
                                    Text(restoran.rating.toString())
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                trailing: isBookmarked
                    ? IconButton(
                        icon: Icon(Icons.bookmark),
                        onPressed: () => provider.removeBookmark(restoran.id),
                      )
                    : IconButton(
                        icon: Icon(Icons.bookmark_border),
                        onPressed: () => provider.addBookmark(restoran),
                      ),
                onTap: () => Navigator.pushNamed(
                  context,
                  RestaurantDetailPage.routeName,
                  arguments: restoran.id,
                ),
              ),
            );
          },
        );
      },
    );
  }
}