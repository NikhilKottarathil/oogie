import 'package:flutter/material.dart';
import 'package:oogie/components/app_bar/secondary_app_bar.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/views/grid_views/product_potrait_gridview.dart';
class FeaturedPhones extends StatefulWidget {
  @override
  _FeaturedPhonesState createState() => _FeaturedPhonesState();
}

class _FeaturedPhonesState extends State<FeaturedPhones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(context: context),
      body: Padding(
        padding:edgePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Featured Phones',style: TextStyles.displayMedium,),
            ProductPortraitGridView(),
          ],

        ),
      ),
    );
  }
}
