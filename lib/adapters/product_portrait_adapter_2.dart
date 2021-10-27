import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/explore/product_description.dart';

class ProductPortraitAdapter2 extends StatelessWidget {
  String productName, price, imageUrl,rating,brandName;

  ProductPortraitAdapter2({this.productName, this.price, this.imageUrl,this.rating,this.brandName});

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
                  Text(productName, style: TextStyles.smallRegular,overflow: TextOverflow.ellipsis,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: Text(rupeesString+price, style: TextStyles.smallMedium,)),
                      Icon(Icons.star,color: AppColors.SecondaryBase,size: 12,),
                      Text(rating, style: TextStyles.tinyRegular,overflow: TextOverflow.ellipsis,),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
