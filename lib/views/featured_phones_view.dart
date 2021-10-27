import 'package:flutter/material.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/explore/featured_phones.dart';
import 'package:oogie/views/grid_views/product_landscape_gridview.dart';

class FeaturedPhoneView extends StatefulWidget {
  @override
  _FeaturedPhoneViewState createState() => _FeaturedPhoneViewState();
}

class _FeaturedPhoneViewState extends State<FeaturedPhoneView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.SurfaceDisabled,
      padding: EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Featured Phones',style: TextStyles.displayMedium,),
              CustomTextButton2(text: 'View all',action: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FeaturedPhones()));
              },)
            ],
          ),
          ProductLandscapeGridView(),
        ],
      ),
    );
  }
}
