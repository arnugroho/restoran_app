import 'package:flutter/material.dart';
import 'package:restoran_app_dicoding/data/model/restoran.dart';

import 'detail_restoran.dart';

class RestoranListPage extends StatelessWidget {
  static const routeName = '/restoran_list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restoran App'),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/data_restoran.json'),
        builder: (context, snapshot) {
          final List<Restoran> restaurants = parseArticles(snapshot.data);
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestoranItem(context, restaurants[index]);
            },
          );
        },
      ),
    );
  }
}

Widget _buildRestoranItem(BuildContext context, Restoran restoran) {
  return Card(
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Center(
          child: ListTile(
            leading: Hero(
                tag: restoran.pictureId,
                child: (Image.network(
                  restoran.pictureId,
                  width: 100,
                ))),
            title: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(restoran.name),
            ),
            subtitle:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(2.0, 0, 0, 0),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
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
                padding: const EdgeInsets.fromLTRB(2.0, 8.0, 0, 4),
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
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
            onTap: () {
              Navigator.pushNamed(context, RestoranDetailPage.routeName,
                  arguments: restoran);
            },
          ),
        ),
      ],
    ),
  );
}


