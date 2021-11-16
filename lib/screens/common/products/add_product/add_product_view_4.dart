import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/multi_file_viewer.dart';
import 'package:oogie/components/popups_loaders/custom_alert_dialoug.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/components/product_specification.dart';
import 'package:oogie/components/ui_widgets/button_with_icon.dart';
import 'package:oogie/constants/form_submitting_status.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/key_value_radio_model.dart';
import 'package:oogie/screens/common/products/add_product/add_product_bloc.dart';
import 'package:oogie/screens/common/products/add_product/add_product_event.dart';
import 'package:oogie/screens/common/products/add_product/add_product_state.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_1.dart';
import 'package:oogie/screens/common/products/add_product/add_product_view_2.dart';
import 'package:oogie/screens/common/products/add_product/add_specification.dart';
import 'package:oogie/screens/common/products/product_filter/filter_list_adapter.dart';
import 'package:oogie/screens/vendor_old/add_product.dart';

class AddProductView4 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        var formStatus = state.formSubmissionStatus;
        if (formStatus is SubmissionFailed) {
          showSnackBar(context, formStatus.exception);
        } else if (formStatus is SubmissionSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                context.read<AddProductBloc>().add(AddHighLight());
              },
              backgroundColor: AppColors.PrimaryBase,
              child: Icon(Icons.add),
            ),
            SizedBox(
              height: 75,
            ),
          ],
        ),
        appBar: defaultAppBarWhite(
            context: context, text: 'Add Product Specification'),
        body: LayoutBuilder(builder: (context, constraints) {
          return Form(
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
                            : state.highlights.length == 0
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Text(
                                          'No highlights',
                                          style:
                                              TextStyles.mediumRegularSubdued,
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          'Please press plus button to add',
                                          style: TextStyles.smallRegularSubdued,
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Wrap(
                                      children: List.generate(
                                          state.highlights.length, (index) {
                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: CustomTextField(
                                                  hintText: 'Enter highlights',
                                                  validator: (value) {
                                                    return value
                                                                .toString()
                                                                .trim()
                                                                .length ==
                                                            0
                                                        ? ''
                                                        : null;
                                                  },
                                                  text: state.highlights[index],
                                                  onChange: (value) {
                                                    context
                                                        .read<AddProductBloc>()
                                                        .add(
                                                          HighLightChanged(
                                                              value: value,
                                                              index: index),
                                                        );
                                                  },
                                                  textInputType:
                                                      TextInputType.text),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20,top: 11),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                child: Icon(
                                                  Icons.delete,
                                                  size: 20,
                                                  color: AppColors.OutlinedIcon,
                                                ),
                                                onTap: () {
                                                  context
                                                      .read<AddProductBloc>()
                                                      .add(
                                                        DeleteHighLight(
                                                            index: index),
                                                      );
                                                },
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                    ),
                                  );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BlocBuilder<AddProductBloc, AddProductState>(
                      builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: state.formSubmissionStatus is FormSubmitting
                          ? CustomProgressIndicator()
                          : DefaultButton(
                              text: 'POST',
                              action: () {
                                if (_formKey.currentState.validate()) {
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
}
