import 'package:flutter/material.dart';
import 'package:oogie/adapters/cart_adapter.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_text_button.dart';

class CartDetailsView extends StatefulWidget {
  @override
  _CartDetailsViewState createState() => _CartDetailsViewState();
}

class _CartDetailsViewState extends State<CartDetailsView> {
  String showText = 'Hide cart details';
  String hideText = 'Show cart details';
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.only(bottom:20.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              isVisible = !isVisible;
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.SurfaceDisabled,
                borderRadius: BorderRadius.circular(4)
              ),
              padding: EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(isVisible ? showText : hideText,
                      style: AppStyles.smallRegularPrimaryLight),
                  isVisible
                      ? Icon(
                          Icons.keyboard_arrow_up_sharp,
                          color: AppColors.OutlinedIcon,
                        )
                      : Icon(
                          Icons.keyboard_arrow_down_sharp,
                          color: AppColors.OutlinedIcon,
                        )
                ],
              ),
            ),
          ),
          Visibility(
            visible: isVisible,
            child: Container(
              color: AppColors.SurfaceDisabled.withOpacity(.6),
              child: Wrap(
                children: [
                  Wrap(
                    children: [
                      CartAdapter(
                        productName: 'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
                        brandName: 'Redmi',
                        price: rupeesString + '10000',
                        imageUrl:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:20.0,top: 20,right: 20),
                    child: Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: AppStyles.smallRegularSubdued,
                            ),
                            Text(
                              rupeesString + '165',
                              style: AppStyles.smallRegularSubdued,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Shipping',
                              style: AppStyles.smallRegularSubdued,
                            ),
                            Text('FREE', style: AppStyles.smallRegularSubdued)
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Expected Delivery',
                              style: AppStyles.smallRegularSubdued,
                            ),
                            Text(
                              'Apr 20 - 28',
                              style: AppStyles.smallRegularSubdued,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Taxes',
                              style: AppStyles.smallRegularSubdued,
                            ),
                            Text(
                              rupeesString + '11.55',
                              style: AppStyles.smallRegularSubdued,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total',
                              style: AppStyles.mediumMedium,
                            ),
                            Text(
                              rupeesString + '176.55',
                              style: AppStyles.mediumMedium,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
