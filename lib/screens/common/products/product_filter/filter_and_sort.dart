import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/category_list_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/common/products/product_filter/filter_list_adapter.dart';
import 'package:oogie/screens/common/products/product_filter/product_filter_bloc.dart';
import 'package:oogie/screens/common/products/product_filter/product_filter_event.dart';
import 'package:oogie/screens/common/products/product_filter/product_filter_state.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

filterAndSort({BuildContext buildContext}) async {
//   showDialog(
//       context: buildContext,
// );

  await showModalBottomSheet(
      context: buildContext,
      enableDrag: false,
      useRootNavigator: true,
      isScrollControlled: true,
      builder: (builder) {
        double height = MediaQuery.of(buildContext).size.height;
        // final _formKey = GlobalKey<FormState>();

        print('page builded');
        return BlocProvider.value(
          value: buildContext.read<ProductFilterBloc>(),
          child: BlocListener<ProductFilterBloc, ProductFilterState>(
            listener: (context, state) {
              print('filtr sort builder listner');

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
                        body: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Wrap(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FilterListAdapter(
                                  filterModel: state.sortFilter,
                                  isMultiSelection: false,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Price Range',
                                      style: TextStyles.smallMedium,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      state.sfRangeValues.start
                                              .toStringAsFixed(0) +
                                          '\t-\t' +
                                          state.sfRangeValues.end
                                              .toStringAsFixed(0),
                                      style: TextStyles.smallRegular,
                                    )
                                  ],
                                ),
                                SfRangeSlider(
                                    values: state.sfRangeValues,
                                    min: 0,
                                    max: 100000,
                                    showTicks: true,
                                    // showLabels: true,
                                    enableTooltip: true,
                                    // labelPlacement: LabelPlacement.betweenTicks,
                                    enableIntervalSelection: true,
                                    stepSize: 500.0,

                                    // labelFormatterCallback:
                                    //     (dynamic actualValue, String formattedText) {
                                    //
                                    //   return ;
                                    // },

                                    onChanged: (values) {
                                      context.read<ProductFilterBloc>().add(
                                          PriceRangeValuesChanged(
                                              sfRangeValues: values));
                                    }),

                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: BlocBuilder<
                                //           ProductFilterBloc,
                                //           ProductFilterState>(
                                //         buildWhen:
                                //             (prevState, newState) {
                                //           return prevState
                                //                   .minimumPrice !=
                                //               newState.minimumPrice;
                                //         },
                                //         builder: (context, state) {
                                //           return CustomTextField(
                                //             hintText: 'Min Price',
                                //             maxLines: 1,
                                //             validator: (value) {
                                //               return state
                                //                   .priceValidator;
                                //             },
                                //             onChange: (value) {
                                //               context
                                //                   .read<
                                //                       ProductFilterBloc>()
                                //                   .add(
                                //                       MinimumPriceChanged(
                                //                           minimumPrice:
                                //                               value));
                                //             },
                                //             text: state.minimumPrice,
                                //             textInputType:
                                //                 TextInputType.number,
                                //           );
                                //         },
                                //       ),
                                //     ),
                                //     SizedBox(
                                //       width: 16,
                                //     ),
                                //     Expanded(
                                //       child: BlocBuilder<
                                //               ProductFilterBloc,
                                //               ProductFilterState>(
                                //           buildWhen:
                                //               (prevState, newState) {
                                //         return prevState.maximumPrice !=
                                //             newState.maximumPrice;
                                //       }, builder: (context, state) {
                                //         return CustomTextField(
                                //           hintText: "Max Price",
                                //           text: state.maximumPrice,
                                //           textInputType:
                                //               TextInputType.phone,
                                //           validator: (value) {
                                //             return state.priceValidator;
                                //           },
                                //           onChange: (value) {
                                //             context
                                //                 .read<
                                //                     ProductFilterBloc>()
                                //                 .add(
                                //                   MaximumPriceChanged(
                                //                       maximumPrice:
                                //                           value),
                                //                 );
                                //           },
                                //           maxLines: 1,
                                //           prefixIcon:
                                //               'icons/smartphone.svg',
                                //           isLabelEnabled: false,
                                //         );
                                //       }),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                  height: 20,
                                ),
                                Wrap(
                                  children: List.generate(
                                      state.filterModels.length,
                                      (index) => FilterListAdapter(
                                            filterModel:
                                                state.filterModels[index],
                                            isMultiSelection: true,
                                          )),
                                ),
                                FilterListAdapter(
                                  filterModel: state.ratingFilter,
                                  isMultiSelection: false,
                                ),
                              ],
                            ),
                          ),
                        ),
                        bottomNavigationBar: Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                          child: DefaultButton(
                            text: 'Apply',
                            action: () {
                              // if (_formKey.currentState.validate()) {
                                buildContext
                                    .read<ProductFilterBloc>()
                                    .add(FilterApplied());
                                Navigator.pop(context);
                              // }
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

// class CustomTextField extends StatelessWidget {
//   final hintText;
//   final prefixIcon;
//   TextInputType textInputType;
//   int maxLines = 1;
//   Function suffixAction;
//   var suffixType;
//   var suffixText;
//   bool isLabelEnabled;
//   var validator;
//   var onChange;
//   var text;
//
//   CustomTextField({
//     this.hintText,
//     this.prefixIcon,
//     this.validator,
//     this.text,
//     this.onChange,
//     this.textInputType,
//     this.suffixText,
//     this.suffixAction,
//     this.isLabelEnabled,
//     this.suffixType,
//     this.maxLines,
//   });
//
//   TextEditingController controller = new TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     if (text != null) {
//       controller.text = text;
//     }
//     if (isLabelEnabled == null) {
//       isLabelEnabled = true;
//     }
//     return Container(
//       margin: EdgeInsets.only(top: 16),
//       decoration: BoxDecoration(
//         color: AppColors.White,
//         borderRadius: new BorderRadius.circular(8.0),
//       ),
//       child: TextFormField(
//         maxLines: maxLines == null ? 1 : maxLines,
//         controller: controller,
//         // onChanged: onChange,
//         validator: validator,
//         obscureText:
//             textInputType == TextInputType.visiblePassword ? true : false,
//         enableSuggestions:
//             textInputType == TextInputType.visiblePassword ? false : true,
//         autocorrect:
//             textInputType == TextInputType.visiblePassword ? false : true,
//
//         style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w400,
//             fontFamily: 'DMSans',
//             color: AppColors.TextDefault),
//         decoration: new InputDecoration(
//           labelText: isLabelEnabled ? hintText : null,
//           hintText: isLabelEnabled ? null : hintText,
//           contentPadding: const EdgeInsets.all(17.0),
//           fillColor: Colors.white,
//           labelStyle: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               fontFamily: 'DMSans',
//               color: AppColors.TextDefault),
//           hintStyle: TextStyle(
//               fontSize: 14,
//               fontWeight: FontWeight.w400,
//               fontFamily: 'DMSans',
//               color: AppColors.TextDefault),
//
//           suffixIcon: suffixType != null
//               ? suffixType == 'optional'
//                   ? SizedBox(
//                       width: MediaQuery.of(context).size.width * .25,
//                       child: Center(
//                         child: Text(
//                           suffixText,
//                           style: TextStyle(
//                               fontSize: 12,
//                               color: AppColors.Grey1Text,
//                               fontWeight: FontWeight.normal),
//                         ),
//                       ),
//                     )
//                   : SizedBox(
//                       width: MediaQuery.of(context).size.width * .25,
//                       child: InkWell(
//                         onTap: () {
//                           suffixAction();
//                         },
//                         child: Center(
//                           child: Text(
//                             suffixText,
//                             style: TextStyle(
//                               color: AppColors.PrimaryBase,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     )
//               : null,
//
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppColors.BorderDefault, width: 1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//
//           enabledBorder: new OutlineInputBorder(
//               borderRadius: new BorderRadius.circular(8.0),
//               borderSide:
//                   new BorderSide(color: AppColors.BorderDisabled, width: 1.0)),
//           errorBorder: new OutlineInputBorder(
//               borderRadius: new BorderRadius.circular(8.0),
//               borderSide:
//                   new BorderSide(color: AppColors.CriticalBase, width: 1.0)),
//           border: AppBorders.transparentBorder,
//           disabledBorder: new OutlineInputBorder(
//               borderRadius: new BorderRadius.circular(8.0),
//               borderSide:
//                   new BorderSide(color: AppColors.BorderDisabled, width: 1.0)),
//           focusedErrorBorder: new OutlineInputBorder(
//               borderRadius: new BorderRadius.circular(8.0),
//               borderSide:
//                   new BorderSide(color: AppColors.CriticalBase, width: 1.0)),
//           //fillColor: Colors.green
//         ),
//         keyboardType: textInputType,
//       ),
//     );
//   }
// }
