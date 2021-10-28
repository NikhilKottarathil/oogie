import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';
// import 'package:oogie/screens/explore/product_description.dart';

class ProductLandscapeAdapter2 extends StatelessWidget {
  String productName, brandName, imageUrl,price,rating;

  ProductLandscapeAdapter2({this.productName, this.brandName, this.imageUrl,this.price,this.rating});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductPage()));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.White,
          boxShadow: AppShadows.shadowSmall,
          borderRadius: BorderRadius.circular(8),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: Image.network(imageUrl, fit: BoxFit.fitHeight),),
            ),
            SizedBox(width: 12,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productName, style: TextStyles.smallRegular,maxLines: 2,overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 8,),

                  Text(brandName, style: TextStyles.smallRegularSubdued,),
                  SizedBox(height: 8,),
                  Text(rupeesString+'23000', style: TextStyles.smallMedium,),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.star,color: AppColors.SecondaryBase,size: 12,),
                      Text(rating, style: TextStyles.tinyRegular,overflow: TextOverflow.ellipsis,),
                    ],
                  )

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
