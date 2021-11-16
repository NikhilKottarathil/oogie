import 'package:flutter/material.dart';
import 'package:oogie/adapters/horizontal_product_adapter.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/product_model.dart';

class HorizontalProductView extends StatelessWidget {
  Function viewAllAction;
  List<ProductModel> productModels;
  String title;

  HorizontalProductView({this.viewAllAction, this.title, this.productModels});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.SurfaceDisabled,
      padding: EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyles.displayMedium,
              ),
              viewAllAction != null
                  ? CustomTextButton2(
                      text: 'View all',
                      action: viewAllAction,
                    )
                  : Container(),
            ],
          ),
          SizedBox(
            height: 24,
          ),
          SizedBox(
            height: 240,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(2),
              scrollDirection: Axis.horizontal,
              itemCount: productModels.length,
              itemBuilder: (context, index) {
                return HorizontalProductAdapter(productModels[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
