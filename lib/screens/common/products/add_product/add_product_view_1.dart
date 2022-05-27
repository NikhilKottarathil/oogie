import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/popups_loaders/custom_alert_dialoug.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/components/ui_widgets/custom_dropdown.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/attribute_model.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/screens/common/products/add_product/add_product_bloc.dart';
import 'package:oogie/screens/common/products/add_product/add_product_event.dart';
import 'package:oogie/screens/common/products/add_product/add_product_state.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_2.dart';
import 'package:oogie/screens/common/products/product_filter/filter_list_adapter.dart';

class AddProductView1 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        var formStatus = state.formSubmissionStatus;

        if (formStatus is SubmissionFailed) {
          showSnackBar(context, formStatus.exception);
        } else if (formStatus is SubmissionSuccess) {
          if(context.read<AddProductBloc>().productIdOld==null){
            Navigator.pop(context);

          }
          Navigator.pop(context);

        }
      },
      child: Scaffold(
        appBar: defaultAppBarWhite(
            context: context, text: 'Add Product Highlights'),
        body: LayoutBuilder(builder: (context, constraints) {
          return Form(
            key: _formKey,
            child: Stack(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight),
                  child: BlocBuilder<AddProductBloc, AddProductState>(
                    builder: (context, state) {
                      return state.isLoading
                          ? CustomProgressIndicator()
                          : ListView(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              padding: EdgeInsets.all(20),
                              children: [
                                // Text(
                                //   'Select Category',
                                //   style: TextStyles.smallMedium,
                                // ),
                                // SizedBox(height: 14),
                                // Wrap(
                                //   children: List.generate(
                                //       state.categories.length,
                                //       (index) => InkWell(
                                //           splashColor: Colors.transparent,
                                //           onTap: () {
                                //             context
                                //                 .read<AddProductBloc>()
                                //                 .add(CategorySelected(
                                //                     index: index));
                                //           },
                                //           child: KeyValueRadioItem(
                                //               KeyValueRadioModel(
                                //                   key: state
                                //                       .categories[index]
                                //                       .name,
                                //                   isSelected: state
                                //                       .categories[index]
                                //                       .isSelected,
                                //                   value: state
                                //                       .categories[index]
                                //                       .name)))),
                                // ),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                // Text(
                                //   'Select Product Brand',
                                //   style: TextStyles.smallMedium,
                                // ),
                                // SizedBox(height: 14),
                                // Wrap(
                                //   children: List.generate(
                                //       state.brands.length,
                                //       (index) => InkWell(
                                //           splashColor: Colors.transparent,
                                //           onTap: () {
                                //             context
                                //                 .read<AddProductBloc>()
                                //                 .add(BrandSelected(
                                //                     index: index));
                                //           },
                                //           child: KeyValueRadioItem(
                                //               state.brands[index]))),
                                // ),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                // Visibility(
                                //   visible: state.models.length != 0,
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       Text(
                                //         'Select Product Model',
                                //         style: TextStyles.smallMedium,
                                //       ),
                                //       SizedBox(height: 14),
                                //       Wrap(
                                //         children: List.generate(
                                //             state.models.length,
                                //             (index) => InkWell(
                                //                 splashColor:
                                //                     Colors.transparent,
                                //                 onTap: () {
                                //                   context
                                //                       .read<
                                //                           AddProductBloc>()
                                //                       .add(ModelSelected(
                                //                           index: index));
                                //                 },
                                //                 child: KeyValueRadioItem(
                                //                     state.models[index]))),
                                //       ),
                                //
                                //       SizedBox(
                                //         height: 20,
                                //       ),
                                //     ],
                                //   ),
                                // ),

                                //
                                Text(
                                  'Basic Details',
                                  style: TextStyles.mediumMediumPrimaryLight,
                                ),
                                CustomTextField(
                                    hintText: 'Product name',
                                    validator: (value) {
                                      return value.toString().trim().length == 0
                                          ? 'Please fill'
                                          : null;
                                    },
                                    text: state.name,
                                    onChange: (value) {
                                      context.read<AddProductBloc>().add(
                                            NameChanged(value: value),
                                          );
                                    },
                                    textInputType: TextInputType.text),
                                CustomTextField(
                                    hintText: 'Unit Price',
                                    validator: (value) {
                                      return value.toString().trim().length == 0
                                          ? 'Please fill'
                                          : null;
                                    },
                                    text: state.unitPrice,
                                    onChange: (value) {
                                      context.read<AddProductBloc>().add(
                                            UnitPriceChanged(value: value),
                                          );
                                    },
                                    textInputType: TextInputType.number),
                                Visibility(
                                  child: CustomTextField(
                                      hintText: 'Offer Price (optional)',
                                      validator: (value) {
                                        return value.toString().trim().length ==
                                                0
                                            ? null
                                            : double.parse(state.offerPrice) <
                                                    double.parse(
                                                        state.unitPrice)
                                                ? null
                                                : 'Offer price is greater than Unit Price';
                                      },
                                      text: state.offerPrice,
                                      onChange: (value) {
                                        context.read<AddProductBloc>().add(
                                              OfferPriceChanged(value: value),
                                            );
                                      },
                                      textInputType: TextInputType.number),
                                ),
                                CustomTextField(
                                    hintText: 'Quantity Available',
                                    validator: (value) {
                                      return value.toString().trim().length == 0
                                          ? 'Please fill'
                                          : null;
                                    },
                                    text: state.qtyAvailable,
                                    onChange: (value) {
                                      context.read<AddProductBloc>().add(
                                            QuantityAvailableChanged(
                                                value: value),
                                          );
                                    },
                                    textInputType: TextInputType.number),
                                CustomTextField(
                                    hintText: 'Product Description',
                                    validator: (value) {
                                      return value.toString().trim().length == 0
                                          ? 'Please fill'
                                          : null;
                                    },
                                    text: state.description,
                                    onChange: (value) {
                                      context.read<AddProductBloc>().add(
                                            DescriptionChanged(value: value),
                                          );
                                    },
                                    maxLines: 10,
                                    textInputType: TextInputType.text),
                                SizedBox(
                                  height: 25,
                                ),

                                Text(
                                  'Configuration',
                                  style: TextStyles.mediumMediumPrimaryLight,
                                ),
                                SizedBox(height: 14),

                                Text(
                                  'Select Category',
                                  style: TextStyles.smallMedium,
                                ),
                                SizedBox(height: 10),

                                CustomDropdown(
                                  items: state.categories
                                      .map((e) => e.name)
                                      .toList(),
                                  selected: state.categories
                                      .singleWhere((e) => e.isSelected)
                                      .name,
                                  action: (String newValue) {
                                    context.read<AddProductBloc>().add(
                                        CategorySelected(
                                            index: state.categories
                                                .map((e) => e.name)
                                                .toList()
                                                .indexOf(newValue)));
                                  },
                                ),

                                Text(
                                  'Select Product Brand',
                                  style: TextStyles.smallMedium,
                                ),
                                SizedBox(height: 10),
                                CustomDropdown(
                                  items:
                                      state.brands.map((e) => e.key).toList(),
                                  selected: state.brands
                                      .singleWhere((e) => e.isSelected)
                                      .key,
                                  action: (String newValue) {
                                    context.read<AddProductBloc>().add(
                                        BrandSelected(
                                            index: state.brands
                                                .map((e) => e.key)
                                                .toList()
                                                .indexOf(newValue)));
                                  },
                                ),

                                Visibility(
                                  visible: state.models.length != 0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Select Product Model',
                                        style: TextStyles.smallMedium,
                                      ),
                                      SizedBox(height: 14),
                                      CustomDropdown(
                                        items: state.models
                                            .map((e) => e.key)
                                            .toList(),
                                        selected: state.models
                                            .singleWhere((e) => e.isSelected)
                                            .key,
                                        action: (String newValue) {
                                          context.read<AddProductBloc>().add(
                                              ModelSelected(
                                                  index: state.models
                                                      .map((e) => e.key)
                                                      .toList()
                                                      .indexOf(newValue)));
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Select Product Unit',
                                  style: TextStyles.smallMedium,
                                ),
                                SizedBox(height: 14),

                                CustomDropdown(
                                  items: state.unitMeasures
                                      .map((e) => e.key)
                                      .toList(),
                                  selected: state.unitMeasures
                                      .singleWhere((e) => e.isSelected)
                                      .key,
                                  action: (String newValue) {
                                    context.read<AddProductBloc>().add(
                                        UnitOfMeasureSelected(
                                            index: state.unitMeasures
                                                .map((e) => e.key)
                                                .toList()
                                                .indexOf(newValue)));
                                  },
                                ),
                                Text(
                                  'Select product attributes',
                                  style: TextStyles.smallMedium,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  children: List.generate(
                                      state.attributes.length,
                                      (index) => _attributeView(
                                          context: context,
                                          attributeIndex: index,
                                          attributeModel:
                                              state.attributes[index])),
                                ),
                                SizedBox(
                                  height: 100,
                                )
                              ],
                            );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BlocBuilder<AddProductBloc, AddProductState>(
                      builder: (context, state) {
                    return state.formSubmissionStatus is FormSubmitting
                        ? CustomProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, bottom: 20, right: 20),
                            child: DefaultButton(
                              text: 'Next',
                              action: () {
                                if (_formKey.currentState.validate()) {
                                  if (state.categories[0].isSelected) {
                                    showSnackBar(
                                        context,
                                        Exception(
                                            'Select Any Category Continue'));
                                  } else if (state.brands[0].isSelected) {
                                    showSnackBar(context,
                                        Exception('Select Any Brand Continue'));
                                  } else if (state.models[0].isSelected) {
                                    showSnackBar(context,
                                        Exception('Select Any Model Continue'));
                                  } else if (state.unitMeasures[0].isSelected) {
                                    showSnackBar(context,
                                        Exception('Select Any Unit Continue'));
                                  } else if (!state.attributes.every(
                                      (element) => element.values.any(
                                          (element) =>
                                              element.isSelected == true))) {
                                    showSnackBar(context,
                                        Exception('Select All Attributes'));
                                  } else {
                                    customAlertDialog(
                                        heading:
                                        'Are you sure create new product',
                                        context: context,
                                        positiveText: 'Save',
                                        positiveAction: () {
                                          context
                                              .read<AddProductBloc>()
                                              .add(AddProductSubmitted());
                                          Navigator.of(context).pop();
                                        });
                                  }
                                }
                              },
                            ),
                          );
                  }),
                )
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _attributeView(
      {BuildContext context,
      AttributeModel attributeModel,
      int attributeIndex}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // dividerDefault,
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                attributeModel.name,
                style: TextStyles.smallMedium,
              ),
              SizedBox(
                height: 4,
              ),
              Wrap(
                children: List.generate(
                    attributeModel.values.length,
                    (index) => InkWell(
                          child: KeyValueRadioItem(KeyValueRadioModel(
                              value: attributeModel.values[index].text,
                              isSelected:
                                  attributeModel.values[index].isSelected,
                              key: attributeModel.values[index].text)),
                          onTap: () {
                            context.read<AddProductBloc>().add(
                                AttributeSelected(
                                    index: attributeIndex,
                                    value: attributeModel.values[index].text));
                          },
                        )),
              )
            ],
          ),
        ),
      ],
    );
  }
}
