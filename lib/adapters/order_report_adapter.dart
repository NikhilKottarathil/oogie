import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/order_model.dart';

class OrderReportAdapter extends StatelessWidget {
  OrderModel model;

  OrderReportAdapter({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.White,
        boxShadow: AppShadows.shadowSmall,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              model.date,
              style: TextStyles.smallRegular,
            ),
            Text(
              model.id,
              style: TextStyles.smallRegular,
            ),
            Text(
              model.total.toStringAsFixed(2),
              style: TextStyles.smallRegular,
            ),
          ]),
    );
  }
}
