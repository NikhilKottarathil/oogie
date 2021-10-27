import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/category_list_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/explore/product_filter/filter_list_adapter.dart';
import 'package:oogie/screens/explore/product_filter/product_filter_bloc.dart';
import 'package:oogie/screens/explore/product_filter/product_filter_event.dart';
import 'package:oogie/screens/explore/product_filter/product_filter_state.dart';

filterAndSort({BuildContext buildContext}) async {
  await showModalBottomSheet(
      context: buildContext,
      enableDrag: false,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (builder) {
        double height = MediaQuery.of(buildContext).size.height;
        final _formKey = GlobalKey<FormState>();

        return BlocProvider.value(
          value: buildContext.read<ProductFilterBloc>(),
          child: BlocListener<ProductFilterBloc, ProductFilterState>(
            listener: (context, state) {
              // if(state.formSubmissionStatus is SubmissionSuccess){
              //   Navigator.of(context).pop()
              // }
            },
            child: BlocBuilder<ProductFilterBloc, ProductFilterState>(
                builder: (context, state) {
              print('filtr sort builder');
              return SizedBox(
                height: height - 30,
                child: state.selectedCategoryId == null
                    ? Scaffold(
                        appBar: defaultAppBarWhite(
                          context: context,
                          text: 'Select Category',
                          prefixWidget: Icon(
                            Icons.close,
                            color: AppColors.OutlinedIcon,
                          ),
                          prefixAction: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        body: ListView.builder(
                            itemCount: state.categoryModels.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  context.read<ProductFilterBloc>().add(
                                      CategorySelected(
                                          categoryId:
                                              state.categoryModels[index].id));
                                },
                                child: CategoryListAdapter(
                                    categoryModel: state.categoryModels[index]),
                              );
                            }),
                      )
                    : Scaffold(
                        appBar: defaultAppBarWhite(
                            context: context,
                            text: 'Filter & Sort',
                            prefixWidget: Icon(
                              Icons.close,
                              color: AppColors.OutlinedIcon,
                            ),
                            prefixAction: () {
                              Navigator.of(context).pop();
                            },
                            suffixWidget: Padding(
                              padding: EdgeInsets.only(
                                right: 20,
                              ),
                              child: Center(
                                child: CustomTextButton2(
                                  text: 'Clear All',
                                  action: () {
                                    context.read<ProductFilterBloc>().add(
                                        CategorySelected(
                                            categoryId:
                                                state.selectedCategoryId));
                                  },
                                ),
                              ),
                            )),
                        body: LayoutBuilder(builder: (context, constraints) {
                          return SingleChildScrollView(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minWidth: constraints.maxWidth,
                                  minHeight: constraints.maxHeight - 50),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: IntrinsicHeight(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FilterListAdapter(
                                          filterModel: state.sortFilter,
                                          isMultiSelection: false,
                                        ),
                                        Text(
                                          'Price Range',
                                          style: TextStyles.smallMedium,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: BlocBuilder<
                                                  ProductFilterBloc,
                                                  ProductFilterState>(
                                                buildWhen: (prevState,newState){
                                                  return prevState.minimumPrice!=newState.minimumPrice;
                                                },
                                                builder: (context, state) {
                                                  return CustomTextField(
                                                    hintText: 'Min Price',
                                                    maxLines: 1,
                                                    validator: (value) {
                                                      return state
                                                          .priceValidator;
                                                    },
                                                    onChange: (value) {
                                                      context
                                                          .read<
                                                              ProductFilterBloc>()
                                                          .add(
                                                              MinimumPriceChanged(
                                                                  minimumPrice:
                                                                      value));
                                                    },
                                                    text: state.minimumPrice,
                                                    textInputType:
                                                        TextInputType.number,
                                                  );
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(
                                              child: BlocBuilder<ProductFilterBloc, ProductFilterState>(
                                                buildWhen: (prevState,newState){
                                                  return prevState.maximumPrice!=newState.maximumPrice;
                                                },
                                                  builder: (context, state) {
                                                    return CustomTextField(
                                                      hintText: "Max Price",
                                                      text: state.maximumPrice,
                                                      textInputType: TextInputType.phone,
                                                      validator: (value) {
                                                        return state.priceValidator;
                                                      },
                                                      onChange: (value) {
                                                        context.read<ProductFilterBloc>().add(
                                                          MaximumPriceChanged(
                                                              maximumPrice: value),
                                                        );
                                                      },
                                                      maxLines: 1,
                                                      prefixIcon: 'icons/smartphone.svg',
                                                      isLabelEnabled: false,
                                                    );
                                                  }),
                                            ),

                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Wrap(
                                          children: List.generate(
                                              state.filterModels.length,
                                              (index) => FilterListAdapter(
                                                    filterModel: state
                                                        .filterModels[index],
                                                    isMultiSelection: true,
                                                  )),
                                        ),
                                        Spacer(),
                                        FilterListAdapter(
                                          filterModel: state.ratingFilter,
                                          isMultiSelection: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                        bottomNavigationBar: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: DefaultButton(
                            text: 'Apply',
                            action: () {
                              if (_formKey.currentState.validate()) {
                                buildContext
                                    .read<ProductFilterBloc>()
                                    .add(FilterApplied());
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                      ),
              );
            }),
          ),
        );
      });
}
