import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';
// import 'package:oogie/screens/common/products/product_description.dart';

class ProductLandscapeAdapter extends StatelessWidget {
  String productName, brandName, imageUrl;

  ProductLandscapeAdapter({this.productName, this.brandName, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductPage()));
      },
      child: Container(
        height: 240,
        width: 210,
        decoration: BoxDecoration(
          color: AppColors.White,
          boxShadow: AppShadows.shadowSmall,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 170,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: Image.network(imageUrl, fit: BoxFit.fitHeight),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    brandName,
                    style: TextStyles.smallMedium,
                  ),
                  Text(
                    productName,
                    style: TextStyles.smallRegular,
                    overflow: TextOverflow.ellipsis,
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
