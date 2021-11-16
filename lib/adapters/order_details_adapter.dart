import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

class OrderDetailsAdapter extends StatefulWidget {
  String status, productName, date, seller, price;

  OrderDetailsAdapter(
      this.status, this.productName, this.date, this.seller, this.price);

  @override
  _OrderDetailsAdapterState createState() => _OrderDetailsAdapterState();
}

class _OrderDetailsAdapterState extends State<OrderDetailsAdapter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgePadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.productName,
                  style: TextStyles.smallRegular,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Redmi',
                  style: TextStyles.smallRegularSubdued,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Seller: Shop4u',
                  style: TextStyles.smallRegular,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  rupeesString + '10030',
                  style: TextStyles.smallMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 12,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(3.0),
            child: Image.asset(
              'refAssets/blue_red_image.png',
              fit: BoxFit.fitWidth,
              width: 120,
            ),
          ),
        ],
      ),
    );
  }
}
