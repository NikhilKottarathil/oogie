import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/multi_file_viewer.dart';
import 'package:oogie/components/popups_loaders/custom_alert_dialoug.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
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
import 'package:oogie/screens/common/products/product_filter/filter_list_adapter.dart';
import 'package:oogie/screens/vendor_old/add_product.dart';

class AddProductView0 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        // var formStatus = state.formSubmissionStatus;
        // if (formStatus is SubmissionSuccess) {
        //   Navigator.pop(context);
        //
        // }
      },
      child: Scaffold(
        appBar: defaultAppBarWhite(
            context: context,
            text: 'Add Product',
            prefixAction: () {
              customAlertDialog(
                  context: context,
                  heading: 'Do you want to close add product?',
                  positiveAction: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
            }),
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
                            : state.images.length == 0
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Column(
                                      children: [
                                        Text(
                                          'No photos to show',
                                          style:
                                              TextStyles.mediumRegularSubdued,
                                        ),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        Text(
                                          'Please select Photos',
                                          style: TextStyles.smallRegularSubdued,
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(
                                    height: 300,
                                    child: MultiFileViewer(
                                      media: state.images,
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
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomButtonWithIcon(
                                  icon: Icons.camera,
                                  text: "Attach Media",
                                  action: () async {
                                    context
                                        .read<AddProductBloc>()
                                        .add(SelectMedia(context: context));
                                  },
                                ),
                                DefaultButton(
                                  text: 'Next',
                                  action: () {
                                    if (state.images.length > 0) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => BlocProvider.value(
                                              value: context
                                                  .read<AddProductBloc>(),
                                              child: AddProductView1(),
                                            ),
                                          ));
                                    } else {
                                      showSnackBar(
                                          context,
                                          Exception(
                                              'Please Add Photos Continue'));
                                    }
                                  },
                                ),
                              ],
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
