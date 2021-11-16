import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/components/app_bar/default_appbar_blue.dart';
import 'package:oogie/components/product_specification.dart';
import 'package:oogie/components/read_more_text.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/product_model.dart';

class ProductDetails extends StatelessWidget {
  ProductModel productModel;

  ProductDetails({this.productModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: secondaryAppBar(context: context),
      appBar: defaultAppBarBlue(context: context, text: 'Product Details'),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(3.0),
                    child: productModel.imageUrl != null
                        ? Image.network(
                            productModel.imageUrl,
                            fit: BoxFit.scaleDown,
                            width: 64,
                            height: 64,
                          )
                        : SvgPicture.asset(
                            Urls().productImage,
                            fit: BoxFit.scaleDown,
                            width: 64,
                            height: 64,
                          )),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        productModel.displayName,
                        style: TextStyles.smallRegular,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        productModel.brandName,
                        style: TextStyles.smallRegularSubdued,
                      ),
                      Text(
                        rupeesString + productModel.unitPrice,
                        style: TextStyles.smallMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dividerDefault,
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyles.smallMedium,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: ReadMoreText(
                              maxLines: 4,
                              text: productModel.description,
                            ))
                      ],
                    ),
                  ),
                  ListView.separated(
                    itemCount: productModel.specificationModels.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(20),
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return specificationView(specificationModel:productModel.specificationModels[index],isEditable: false);
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 20,
                      );
                    },
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


