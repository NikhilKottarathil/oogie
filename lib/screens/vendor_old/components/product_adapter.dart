import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/styles.dart';
// import 'package:oogie/screens/common/products/product_description.dart';
import 'package:oogie/screens/vendor_old/add_product.dart';
import 'package:share/share.dart';

import 'delete_product.dart';

class ProductAdapter extends StatelessWidget {
  String productName, brandName, imageUrl, price, rating;

  ProductAdapter(
      {this.productName,
      this.brandName,
      this.imageUrl,
      this.price,
      this.rating});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddProduct(
                  title: 'Edit Product',
                )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.White,
          boxShadow: AppShadows.shadowSmall,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
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
                        style: TextStyles.smallRegular,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        'REDMI15875098600064587',
                        style: TextStyles.tinyRegularSubdued,
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        'Qty: 12',
                        style: TextStyles.smallRegularSubdued,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            rupeesString + '23000',
                            style: TextStyles.smallMedium,
                          ),
                          Text(
                            '12/08/2022',
                            style: TextStyles.smallRegularSubdued,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            dividerDefault,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // CustomTextButton2(text: 'View',action: (){
                //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductPage()));
                // },),
                SizedBox(
                  width: 12,
                ),
                InkWell(
                    onTap: () async {
                      await Share.share("text");
                    },
                    child: SvgPicture.asset(
                      'icons/share.svg',
                      height: 24,
                    )),
                SizedBox(
                  width: 12,
                ),

                InkWell(
                    onTap: () {
                      deleteProduct(buildContext: context);
                    },
                    child: SvgPicture.asset(
                      'icons/delete.svg',
                      height: 24,
                      color: AppColors.TextSubdued,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
