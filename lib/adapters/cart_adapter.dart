import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';

class CartAdapter extends StatefulWidget {
  String productName, brandName, imageUrl, price;

  CartAdapter({this.productName, this.brandName, this.imageUrl, this.price});

  @override
  _CartAdapterState createState() => _CartAdapterState();
}

class _CartAdapterState extends State<CartAdapter> {
  int qty = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: edgePadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: Image.asset(
                  'refAssets/blue_red_image.png',
                  fit: BoxFit.fitWidth,
                  width: 64,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          widget.productName,
                          style: AppStyles.smallRegular,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                        IconButton(
                            icon: SvgPicture.asset('icons/delete.svg'),
                            splashColor: Colors.transparent,
                            onPressed: () {}),
                      ],
                    ),
                    Text(
                      widget.brandName,
                      style: AppStyles.smallRegularSubdued,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Row(

                          children: [
                            Text(
                              'Qty:',
                              style: AppStyles.smallRegular,
                            ),
                            Row(
                              children: [
                                IconButton(
                                    icon:
                                        SvgPicture.asset('icons/minus_square.svg'),
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      if (qty > 0) {
                                        qty -= 1;
                                        setState(() {});
                                      }
                                    }),
                                Text(
                                  qty.toString(),
                                  style: AppStyles.mediumRegular,
                                ),
                                IconButton(
                                    icon: SvgPicture.asset('icons/plus_square.svg'),
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      qty += 1;

                                      setState(() {});
                                    }),
                              ],
                            )
                          ],
                        ),
                        Text(widget.price,style: AppStyles.smallMedium,)

                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: AppColors.DividerBase,
          thickness: 1,
        )
      ],
    );
  }
}
