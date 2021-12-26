import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/components/radio_buttons.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/attribute_model.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/screens/common/products/add_product/add_product_bloc.dart';
import 'package:oogie/screens/common/products/add_product/add_product_event.dart';
import 'package:oogie/screens/common/products/add_product/add_product_state.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_2.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_3.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_3.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_4.dart';
import 'package:oogie/screens/common/products/product_filter/filter_list_adapter.dart';
import 'package:oogie/screens/vendor_old/add_product.dart';

class AddProductView2 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
        listener: (context, state) {
          var formStatus=state.formSubmissionStatus;
          // if (formStatus is SubmissionSuccess) {
          //   Navigator.pop(context);
          //
          // }
        },
      child: Scaffold(
        appBar: defaultAppBarWhite(context: context, text: 'Add Product'),
        body: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                          minHeight: constraints.maxHeight),
                      child: BlocBuilder<AddProductBloc, AddProductState>(
                        builder: (context, state) {
                          return state.isLoading
                              ? CustomProgressIndicator()
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomTextField(
                                        hintText: 'Product name',
                                        validator: (value) {
                                          return value
                                                      .toString()
                                                      .trim()
                                                      .length ==
                                                  0
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
                                          return value
                                                      .toString()
                                                      .trim()
                                                      .length ==
                                                  0
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
                                    Visibility(child: CustomTextField(
                                        hintText: 'Offer Price (optional)',
                                        validator: (value) {
                                          return value
                                              .toString()
                                              .trim()
                                              .length ==
                                              0
                                              ? null
                                              : double.parse(state.offerPrice)<double.parse(state.unitPrice)?null:'Offer price is greater than Unit Price';
                                        },
                                        text: state.offerPrice,
                                        onChange: (value) {
                                          context.read<AddProductBloc>().add(
                                            OfferPriceChanged(value: value),
                                          );
                                        },
                                        textInputType: TextInputType.number),),
                                    CustomTextField(
                                        hintText: 'Quantity Available',
                                        validator: (value) {
                                          return value
                                                      .toString()
                                                      .trim()
                                                      .length ==
                                                  0
                                              ? 'Please fill'
                                              : null;
                                        },
                                        text: state.qtyAvailable,
                                        onChange: (value) {
                                          context.read<AddProductBloc>().add(
                                            QuantityAvailableChanged(value: value),
                                              );
                                        },
                                        textInputType: TextInputType.number),
                                    CustomTextField(
                                        hintText: 'Product Description',
                                        validator: (value) {
                                          return value
                                                      .toString()
                                                      .trim()
                                                      .length ==
                                                  0
                                              ? 'Please fill'
                                              : null;
                                        },
                                        text: state.description,
                                        onChange: (value) {
                                          context.read<AddProductBloc>().add(
                                                DescriptionChanged(
                                                    value: value),
                                              );
                                        },
                                        maxLines: 10,
                                        textInputType: TextInputType.text),
                                    SizedBox(height: 20,),
                                    Text(
                                      'Select Product Unit',
                                      style: TextStyles.smallMedium,
                                    ),
                                    SizedBox(height: 14),
                                    Wrap(
                                      children: List.generate(
                                          state.unitMeasures.length,
                                              (index) => InkWell(
                                              splashColor: Colors.transparent,
                                              onTap: () {
                                                context
                                                    .read<AddProductBloc>()
                                                    .add(UnitOfMeasureSelected(
                                                    index: index));
                                              },
                                              child: KeyValueRadioItem(
                                                  state.unitMeasures[index]))),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text('Select product attributes',style: TextStyles.mediumMedium,),
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
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BlocBuilder<AddProductBloc, AddProductState>(
                        builder: (context, state) {
                      return state.formSubmissionStatus is FormSubmitting
                          ? CustomProgressIndicator()
                          : DefaultButton(
                              text: 'Next',
                              action: () {
                                if (_formKey.currentState.validate()) {
                                 if (!state.unitMeasures
                                    .any((element) => element.isSelected)) {
                                  showSnackBar(
                                      context,
                                      Exception(
                                          'Select Any Unit Continue'));
                                }else if (!state.attributes.every((element) => element.values.any((element) => element.isSelected==true))) {
                                   showSnackBar(
                                       context,
                                       Exception(
                                           'Select All Attributes'));
                                 }else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: context.read<AddProductBloc>(),
                                          child: AddProductView3(),
                                        ),
                                      ));
                                }
                                }
                              },
                            );
                    }),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

Widget _attributeView(
    {BuildContext context, AttributeModel attributeModel, int attributeIndex}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      dividerDefault,
      Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              attributeModel.name,
              style: TextStyles.smallMedium,
            ),
            Wrap(
              children: List.generate(
                  attributeModel.values.length,
                  (index) => InkWell(
                        child: KeyValueRadioItem(KeyValueRadioModel(value: attributeModel.values[index].text,isSelected: attributeModel.values[index].isSelected,key: attributeModel.values[index].text)),
                        onTap: () {
                          context.read<AddProductBloc>().add(AttributeSelected(
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
