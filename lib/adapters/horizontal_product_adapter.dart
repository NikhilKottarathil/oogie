import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/product_model.dart';

class HorizontalProductAdapter extends StatelessWidget {
  ProductModel productModel;

  HorizontalProductAdapter(this.productModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/product',
            arguments: {'id': productModel.id});
      },
      child: Container(
        height: 210,
        width: 240,
        margin: EdgeInsets.only(right: 15),
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
              child: Center(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(3.0),
                    child: productModel.imageUrl != null
                        ? Image.network(productModel.imageUrl,
                            fit: BoxFit.fitWidth)
                        : SvgPicture.asset(Urls().productImage,
                            fit: BoxFit.fitWidth)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productModel.brandName,
                    style: TextStyles.smallMedium,
                  ),
                  Text(productModel.displayName,
                      style: TextStyles.smallRegular,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
