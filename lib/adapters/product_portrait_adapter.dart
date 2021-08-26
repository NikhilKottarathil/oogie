import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/screens/explore/product_description.dart';

class ProductPortraitAdapter extends StatelessWidget {
  String productName, brandName, imageUrl;

  ProductPortraitAdapter({this.productName, this.brandName, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductPage()));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.White,
          boxShadow: AppShadows.shadowSmall,
          borderRadius: BorderRadius.circular(8),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(3.0),
              child: Image.network(imageUrl, fit: BoxFit.fitWidth),),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(brandName, style: AppStyles.smallMedium,),
                  Text(productName, style: AppStyles.smallRegular,overflow: TextOverflow.ellipsis,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
