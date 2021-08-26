import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/screens/explore/product_description.dart';
import 'package:oogie/screens/vendor/add_product.dart';
import 'package:oogie/screens/vendor/order_view.dart';
import 'package:share/share.dart';

import 'delete_product.dart';

class OrderAdapter extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OrderView()));
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('ORDER15875098600064587', style: AppStyles.smallRegular,),
                    Text('12/08/2022', style: AppStyles.smallRegularSubdued,overflow: TextOverflow.ellipsis,),

                  ],
                ),
                Text('QTY: 12', style: AppStyles.smallRegularSubdued,overflow: TextOverflow.ellipsis,),
                SizedBox(height: 2,),

                Text('Delivery Date : 12/08/2022', style: AppStyles.smallRegular,maxLines: 2,overflow: TextOverflow.ellipsis,),


                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(rupeesString+'23000', style: AppStyles.smallMedium,),
                    Row(
                      children: [
                        // CustomTextButton2(text: 'View',action: (){
                        //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductPage()));
                        // },),
                        SizedBox(width: 12,),
                        InkWell(onTap:() async {
                          await Share.share("text");
                        },child: SvgPicture.asset('icons/share.svg',height: 24,)),
                      ],
                    )

                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
