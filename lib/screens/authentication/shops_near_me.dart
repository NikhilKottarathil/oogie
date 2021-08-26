import 'package:flutter/material.dart';
import 'package:oogie/adapters/shop_adapter.dart';
import 'package:oogie/components/custom_app_bars.dart';
class ShopsNearMe extends StatefulWidget {
  String location;
  ShopsNearMe(this.location);
  @override
  _ShopsNearMeState createState() => _ShopsNearMeState();
}

class _ShopsNearMeState extends State<ShopsNearMe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarWhite(text: widget.location,context: context),
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
