import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/screens/common/products/add_product/add_product_bloc.dart';
import 'package:oogie/screens/common/products/add_product/add_product_event.dart';

addSpecification({BuildContext buildContext, int index}) async {
  String title = '';
  String subTitleValue = '';
  String subTitleKey = '';

  showDialog(
    context: buildContext,
    useSafeArea: true,

    builder: (context){
      return Material(
        child: BlocProvider.value(
          value: buildContext.read<AddProductBloc>(),
          child: StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Product Specification',
                          style: TextStyles.largeMedium,
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
                   index==null? CustomTextField(
                      hintText: 'Title',
                      onChange: (value) {
                        title = value;
                      },
                      validator: (value) {
                        return value.toString().trim().length == 0
                            ? 'Please fill'
                            : null;
                      },
                      text: title,
                      textInputType: TextInputType.text,
                    ):Container(),
                    SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      hintText: 'Heading',
                      onChange: (value) {
                        subTitleKey = value;
                      },
                      validator: (value) {
                        return value.toString().trim().length == 0
                            ? 'Please fill'
                            : null;
                      },
                      text: subTitleKey,
                      textInputType: TextInputType.text,
                    ),
                    CustomTextField(
                      hintText: 'Description',
                      onChange: (value) {
                        subTitleValue = value;
                      },
                      validator: (value) {
                        return value.toString().trim().length == 0
                            ? 'Please fill'
                            : null;
                      },
                      text: subTitleValue,
                      maxLines: 5,
                      textInputType: TextInputType.text,
                    ),
                    DefaultButton(
                      text: 'Add',
                      action: () {
                        if (index == null) {
                          context.read<AddProductBloc>().add(
                              AddNewSpecification(
                                  specificationModel:
                                  SpecificationModel(
                                      heading: title,
                                      values: [
                                        SubSpecificationModel(
                                            key: subTitleKey,
                                            value: subTitleValue)
                                      ])));
                        } else {
                          context.read<AddProductBloc>().add(
                              AddNewSpecification(
                                  subSpecificationModel:  SubSpecificationModel(
                                      key: subTitleKey,
                                      value: subTitleValue),index: index));
                        }
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      );

    }
  );
  // await showModalBottomSheet(
  //     context: buildContext,
  //     enableDrag: true,
  //     useRootNavigator: true,
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  //     ),
  //     builder: (builder) {
  //       double height = MediaQuery.of(buildContext).size.height;
  //
  //     });
}
