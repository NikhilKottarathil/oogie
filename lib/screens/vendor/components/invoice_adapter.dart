import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/styles.dart';
import 'package:share/share.dart';

class InvoiceAdapter extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>OrderView()));
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
                    Text('INVOICE0000664587', style: TextStyles.smallRegular,),
                    Text('12/08/2022', style: TextStyles.smallRegularSubdued,overflow: TextOverflow.ellipsis,),

                  ],
                ),
                // Text('QTY: 12', style: TextStyles.smallRegularSubdued,overflow: TextOverflow.ellipsis,),
                // SizedBox(height: 2,),
                //
                // Text('Delivery Date : 12/08/2022', style: TextStyles.smallRegular,maxLines: 2,overflow: TextOverflow.ellipsis,),
                //

                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text(rupeesString+'23000', style: TextStyles.smallMedium,),
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
