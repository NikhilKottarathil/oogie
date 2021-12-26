import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/screens/common/products/add_product/add_product_bloc.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_0.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_1.dart';
import 'package:oogie/screens/vendor/product_list_by_creator/product_list_by_creator_bloc.dart';

class ProductByCreatorAdapter extends StatelessWidget {
  ProductModel productModel;

  ProductByCreatorAdapter(this.productModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.White,
        boxShadow: AppShadows.shadowSmall,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: (MediaQuery.of(context).size.width - 80) / 2,
            height: (MediaQuery.of(context).size.width - 80) / 2,
            child: Center(
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(3.0),
                  child: productModel.imageUrl != null
                      ? Image.network(productModel.imageUrl,
                      fit: BoxFit.fitWidth)
                      : SvgPicture.asset(Urls().productImage,
                      fit: BoxFit.fitWidth)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    productModel.displayName,
                    style: TextStyles.smallRegular,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    productModel.brandName,
                    style: TextStyles.smallMedium,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomTextButton2(
                  action: (){
                    Navigator.pushNamed(context, '/product',
                        arguments: {'id': productModel.id});
                  },
                  text: 'View',
                ),
                CustomTextButton2(
                  action: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (_) => BlocProvider(
                      create: (_) => AddProductBloc(
                          productIdOld: productModel.id,
                          productListByCreatorBloc: context
                              .read<ProductListByCreatorBloc>(),
                          productRepository: context
                              .read<ProductListByCreatorBloc>()
                              .productRepository,
                          parentPage:context
                              .read<ProductListByCreatorBloc>()
                              .parentPage),
                      child: AddProductView1(),
                    ),
                    ));
                  },
                  text: 'Edit',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
