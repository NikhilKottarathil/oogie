import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/shop_model.dart';
class ShopAdapter extends StatelessWidget {
  ShopModel shopModel;
  ShopAdapter({@required this.shopModel});
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(left: 14,right: 14,bottom: 20,top: 20),
      decoration: BoxDecoration(
        boxShadow: AppShadows.shadowSmall,
        borderRadius: BorderRadius.circular(8),
        color: AppColors.White
      ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            shopModel.imageUrl!=null?Image.network(shopModel.imageUrl):Image.asset('refAssets/store_icon.png'),
            SizedBox(
              height: 14,
            ),
            Flexible(child: Text(shopModel.name,style: TextStyles.mediumRegular,textAlign: TextAlign.center,)),
            // Spacer(),
            // Icon(Icons.arrow_forward_ios_sharp,color: AppColors.OutlinedIcon,),

          ],
        ),
    );
  }
}
