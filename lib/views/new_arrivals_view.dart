import 'package:flutter/material.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/screens/explore/new_arrivals.dart';
import 'package:oogie/views/grid_views/product_potrait_gridview.dart';

class NewArrivalsView extends StatefulWidget {
  @override
  _NewArrivalsViewState createState() => _NewArrivalsViewState();
}

class _NewArrivalsViewState extends State<NewArrivalsView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('New Arrivals',style: AppStyles.displayMedium,),
              CustomTextButton2(text: 'View all',action: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>NewArrivals()));
              },)
            ],
          ),
          ProductPortraitGridView(),
        ],
      ),
    );
  }
}
