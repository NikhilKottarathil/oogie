import 'package:flutter/material.dart';
import 'package:oogie/components/custom_app_bars.dart';

import 'adapters/favorite_adapter.dart';
import 'adapters/product_landscape_adapter_2.dart';
import 'adapters/product_portrait_adapter_2.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarBlue(text: 'Favorites', context: context),
      body:
      ListView(
        padding: EdgeInsets.only(left: 20,right: 20,top: 16,bottom: 20),
        shrinkWrap: true,
        children: [
          FavoriteAdapter(
              price: "10030",
              brandName: 'Redmi',
              productName: 'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
              rating: '4',
              imageUrl:
              'https://www.gizbot.com/images/2019-07/vivo-s1_156352984560.jpg'
          ),
          FavoriteAdapter(
              price: "10030",
              brandName: 'Redmi',
              productName: 'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
              rating: '4',
              imageUrl:
              'https://www.gizbot.com/images/2019-07/vivo-s1_156352984560.jpg'
          ),
          FavoriteAdapter(
              price: "10030",
              brandName: 'Redmi',
              productName: 'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
              rating: '4',
              imageUrl:
              'https://www.gizbot.com/images/2019-07/vivo-s1_156352984560.jpg'
          ),
        ],
      ),
    );
  }
}
