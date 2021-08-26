import 'package:flutter/material.dart';
import 'package:oogie/components/custom_app_bars.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/views/grid_views/product_potrait_gridview.dart';
class NewArrivals extends StatefulWidget {
  @override
  _NewArrivalsState createState() => _NewArrivalsState();
}

class _NewArrivalsState extends State<NewArrivals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(context: context),
      body: Container(
        padding:edgePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('New Arrivals',style: AppStyles.displayMedium,),
            ProductPortraitGridView(),
          ],

        ),
      ),
    );
  }
}
