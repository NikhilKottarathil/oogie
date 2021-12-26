import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/product_model.dart';

class VerticalProductAdapter extends StatelessWidget {
  ProductModel productModel;

  VerticalProductAdapter(this.productModel);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/product',
            arguments: {'id': productModel.id});
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.White,
          boxShadow: AppShadows.shadowSmall,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width - 80) / 2,
              height: (MediaQuery.of(context).size.width - 80) / 2,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   productModel.brandName!=null?productModel.brandName:'',
                //   style: TextStyles.smallMedium,
                // ),
                Text(
                  productModel.displayName,
                  style: TextStyles.smallRegular,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                productModel.offerPrice == null
                    ? Text(
                        rupeesString + productModel.unitPrice,
                        style: TextStyles.smallMedium,
                      )
                    : Row(
                        children: [
                          Text(
                            productModel.unitPrice,
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.TextSubdued,
                                height: 1.43,
                                fontFamily: 'DMSans',
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            rupeesString + productModel.offerPrice,
                            style: TextStyles.smallMedium,
                          ),
                        ],
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
