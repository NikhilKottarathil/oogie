import 'package:flutter/material.dart';
import 'package:oogie/adapters/shop_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/models/location_model.dart';
class ShopsNearMe extends StatefulWidget {
  LocationModel locationModel;
  ShopsNearMe(this.locationModel);
  @override
  _ShopsNearMeState createState() => _ShopsNearMeState();
}

class _ShopsNearMeState extends State<ShopsNearMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarWhite(text: widget.locationModel.name,context: context),
      body: ListView(
        padding: EdgeInsets.all(20),
        shrinkWrap: true,
        children: [
          ShopAdapter(),
          ShopAdapter(),
          ShopAdapter(),
        ],
      ),
    );
  }
}
