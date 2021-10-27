import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

class OrderAdapter extends StatefulWidget {

  String status,productName,date;
  OrderAdapter(this.status,this.productName,this.date);

  @override
  _OrderAdapterState createState() => _OrderAdapterState();
}

class _OrderAdapterState extends State<OrderAdapter> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: AppShadows.shadowSmall,
        color: AppColors.White
      ),
      padding: edgePadding,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(3.0),
                child: Image.asset(
                  'refAssets/blue_red_image.png',
                  fit: BoxFit.fitWidth,
                  width: 120,
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
                      widget.status,
                      style: TextStyles.smallMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.productName,
                      style: TextStyles.smallRegular,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      widget.date,
                      style: TextStyles.smallRegularSubdued,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
