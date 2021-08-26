import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/screens/explore/product_description.dart';

class FavoriteAdapter extends StatelessWidget {
  String productName, brandName, imageUrl, price, rating;

  FavoriteAdapter(
      {this.productName,
      this.brandName,
      this.imageUrl,
      this.price,
      this.rating});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProductPage()));
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
              height: 130,
              width: 130,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: Image.network(imageUrl, fit: BoxFit.fitHeight),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: AppStyles.smallRegular,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Text(
                    brandName,
                    style: AppStyles.smallRegularSubdued,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    rupeesString + '23000',
                    style: AppStyles.smallMedium,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: AppColors.SecondaryBase,
                        size: 12,
                      ),
                      Text(
                        rating,
                        style: AppStyles.tinyRegular,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      CustomTextButton2(
                        text: 'Add to Cart',
                        action: () {},
                      )
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
