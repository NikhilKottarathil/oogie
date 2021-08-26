import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_app_bars.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: secondaryAppBar(context: context),
      appBar: defaultAppBarBlue(context: context, text: 'Product Details'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: Image.asset(
                    'refAssets/blue_red_image.png',
                    fit: BoxFit.fitWidth,
                    width: 64,
                    height: 64,
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
                      Text(
                        'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
                        style: AppStyles.smallRegular,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "Redmi",
                        style: AppStyles.smallRegularSubdued,
                      ),
                      Text(
                        rupeesString + ' 10000',
                        style: AppStyles.smallMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          dividerDefault,
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'General',
                  style: AppStyles.smallMedium,
                ),
                dividerDefault,
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Model Model',
                        style: AppStyles.smallRegularSubdued,
                      ),
                      Text(
                        'MI9PRO19',
                        style: AppStyles.smallMedium,
                      )
                    ],
                  ),
                ),
                dividerDefault,
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Color',
                        style: AppStyles.smallRegularSubdued,
                      ),
                      Text(
                        'Cool Blue',
                        style: AppStyles.smallMedium,
                      )
                    ],
                  ),
                ),
                dividerDefault,
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sim Type',
                        style: AppStyles.smallRegularSubdued,
                      ),
                      Text(
                        'Dual Sim',
                        style: AppStyles.smallMedium,
                      )
                    ],
                  ),
                ),
                dividerDefault,
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Touch Screen',
                        style: AppStyles.smallRegularSubdued,
                      ),
                      Text(
                        'Yes',
                        style: AppStyles.smallMedium,
                      )
                    ],
                  ),
                ),
                dividerDefault,
              ],
            ),
          )
        ],
      ),
    );
  }
}
