import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/screens/common/products/add_product/add_product_bloc.dart';
import 'package:oogie/screens/common/products/add_product/add_product_event.dart';
import 'package:oogie/screens/common/products/add_product/add_product_state.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_2.dart';
import 'package:oogie/screens/common/products/product_filter/filter_list_adapter.dart';
import 'package:oogie/screens/vendor_old/add_product.dart';

class AddProductView1 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
        listener: (context, state) {
          var formStatus=state.formSubmissionStatus;
          // if (formStatus is SubmissionSuccess) {
            // Navigator.pop(context);

          // }
        },
      child: Scaffold(
        appBar: defaultAppBarWhite(
            context: context, text: 'Add Product Highlights'),
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
                                    Text(
                                      'Select Category',
                                      style: TextStyles.smallMedium,
                                    ),
                                    SizedBox(height: 14),
                                    Wrap(
                                      children: List.generate(
                                          state.categories.length,
                                          (index) => InkWell(
                                              splashColor: Colors.transparent,
                                              onTap: () {
                                                context
                                                    .read<AddProductBloc>()
                                                    .add(CategorySelected(
                                                        index: index));
                                              },
                                              child: KeyValueRadioItem(
                                                  KeyValueRadioModel(
                                                      key: state
                                                          .categories[index]
                                                          .name,
                                                      isSelected: state
                                                          .categories[index]
                                                          .isSelected,
                                                      value: state
                                                          .categories[index]
                                                          .name)))),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Select Product Brand',
                                      style: TextStyles.smallMedium,
                                    ),
                                    SizedBox(height: 14),
                                    Wrap(
                                      children: List.generate(
                                          state.brands.length,
                                          (index) => InkWell(
                                              splashColor: Colors.transparent,
                                              onTap: () {
                                                context
                                                    .read<AddProductBloc>()
                                                    .add(BrandSelected(
                                                        index: index));
                                              },
                                              child: KeyValueRadioItem(
                                                  state.brands[index]))),
                                    ),
                                    SizedBox(
                                      height: 20,
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
                                          Wrap(
                                            children: List.generate(
                                                state.models.length,
                                                (index) => InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      context
                                                          .read<
                                                              AddProductBloc>()
                                                          .add(ModelSelected(
                                                              index: index));
                                                    },
                                                    child: KeyValueRadioItem(
                                                        state.models[index]))),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
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
                                if (!state.categories
                                    .any((element) => element.isSelected)) {
                                  showSnackBar(
                                      context,
                                      Exception(
                                          'Select Any Category Continue'));
                                } else if (!state.brands
                                    .any((element) => element.isSelected)) {
                                  showSnackBar(
                                      context,
                                      Exception(
                                          'Select Any Brand Continue'));
                                }else if (!state.models
                                    .any((element) => element.isSelected)) {
                                  showSnackBar(
                                      context,
                                      Exception(
                                          'Select Any Model Continue'));
                                }else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: context.read<AddProductBloc>(),
                                          child: AddProductView2(),
                                        ),
                                      ));
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
