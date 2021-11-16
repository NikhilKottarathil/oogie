import 'package:flutter/material.dart';
import 'package:oogie/adapters/vertical_product_adapter.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/product_model.dart';

class VerticalProductView extends StatelessWidget {
  Function viewAllAction;
  List<ProductModel> productModels;
  String title;

  VerticalProductView({this.viewAllAction, this.title, this.productModels});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              CustomTextButton2(
                text: 'View all',
                action: viewAllAction,
              )
            ],
          ),
          SizedBox(
            height: 24,
          ),
          GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(2),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15),
            itemCount: productModels.length,
            itemBuilder: (context, index) {
              return VerticalProductAdapter(productModels[index]);
            },
          ),
        ],
      ),
    );
  }
}
