import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/radio_buttons.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/attribute_model.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/screens/explore/product/product_bloc.dart';
import 'package:oogie/screens/explore/product/product_event.dart';
import 'package:oogie/screens/explore/product/product_state.dart';

selectVariant(
    {@required BuildContext buildContext,
    @required ProductModel productModel}) async {
  // Map<String, dynamic> selectedVariant;
  // await Future.forEach(productModel.variants, (variant) {
  //   if (productModel.id.toString() == variant['product_id'].toString()) {
  //     selectedVariant = variant;
  //   }
  // });

  await showModalBottomSheet(
      context: buildContext,
      enableDrag: false,
      useRootNavigator: true,
      isScrollControlled: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(buildContext).size.height - 30,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (builder) {
        return BlocProvider.value(
          value: buildContext.read<ProductBloc>(),
          child:
              BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Select Variant',
                            style: TextStyles.largeRegular,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              color: AppColors.TextDefault,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        state.variantProductName,
                        // 'display_name',
                        style: TextStyles.mediumRegular,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: state.productModel.attributes.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return _attributeView(
                            attributeModel:
                                state.productModel.attributes[index],
                            attributeIndex: index);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DefaultButton(
                    active: state.variantProductId != null,
                    text: 'Apply',
                    errorText: state.variantProductId == null
                        ? 'The combination does not exist'
                        : '',
                    action: () {
                      if (state.variantProductId != null) {
                        context.read<ProductBloc>().add(FetchProductData());
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            );
          }),
        );
      });
}

Widget _attributeView({AttributeModel attributeModel, int attributeIndex}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dividerDefault,
      Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              attributeModel.name,
              style: TextStyles.smallMedium,
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                  padding: EdgeInsets.only(right: 12, top: 12, bottom: 12),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: attributeModel.values.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      child: RadioItem(attributeModel.values[index]),
                      onTap: () {
                        context.read<ProductBloc>().add(CheckProductVariant(
                            index: attributeIndex,
                            value: attributeModel.values[index].text));
                      },
                    );
                  }),
            )
          ],
        ),
      ),
    ],
  );
}
