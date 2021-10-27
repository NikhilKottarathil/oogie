import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/product_model.dart';

class WishlistAdapter extends StatelessWidget {
  ProductModel productModel;
  Function deleteAction;

  WishlistAdapter(
      {this.productModel,this.deleteAction});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          InkWell(
            onTap: (){
              Navigator.of(context)
                  .pushNamed('/product',arguments:{'id':productModel.id,'parentPage':'wishlist'});
            },
            child: SizedBox(
              height: 130,
              width: 130,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child:productModel.imageUrl!=null? Image.network(productModel.imageUrl, fit: BoxFit.scaleDown):SvgPicture.asset(Urls().productImage, fit: BoxFit.scaleDown)),
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
                  productModel.displayName,
                  style: TextStyles.smallRegular,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                Text(
                  productModel.brandName,
                  style: TextStyles.smallRegularSubdued,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  rupeesString + productModel.unitPrice,
                  style: TextStyles.smallMedium,
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
                      productModel.rating,
                      style: TextStyles.tinyRegular,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    CustomTextButton2(
                      text: 'Remove',
                      action: () {
                        deleteAction();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
