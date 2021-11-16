import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_text_field.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/multi_file_viewer.dart';
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
import 'package:oogie/screens/common/products/add_product/add_product_view_4.dart';
import 'package:oogie/screens/common/products/add_product/add_specification.dart';
import 'package:oogie/screens/common/products/product_filter/filter_list_adapter.dart';
import 'package:oogie/screens/vendor_old/add_product.dart';

class AddProductView3 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddProductBloc, AddProductState>(
      listener: (context, state) {
        var formStatus=state.formSubmissionStatus;
         // if (formStatus is SubmissionSuccess) {
         //  Navigator.pop(context);
        //
        // }
      },      child: Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: (){
                addSpecification(buildContext: context);
              },
              backgroundColor: AppColors.PrimaryBase,
              child: Icon(Icons.add),
            ),
            SizedBox(height: 75,),

          ],
        ),
        appBar: defaultAppBarWhite(context: context, text: 'Add Product Specification'),
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
                            :   state.specificationModels.length== 0?Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Text('No detailed specifications',style: TextStyles.mediumRegularSubdued,),
                              SizedBox(height: 14,),
                              Text('Please press plus button to add',style: TextStyles.smallRegularSubdued,),
                            ],
                          ),
                        ):               ListView.separated(
                          itemCount: state.specificationModels.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.all(20),
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return specificationView(
                                specificationModel:state.specificationModels[index],addAction: (){
                              addSpecification(buildContext: context,index: index);

                            },deleteAction: (){
                              context.read<AddProductBloc>().add(
                                  DeleteSpecification(
                                      index: index));
                            },isEditable: true);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: BlocBuilder<AddProductBloc, AddProductState>(
                      builder: (context, state) {
                        return  Padding(
                          padding: EdgeInsets.all(20),
                          child: state.formSubmissionStatus is FormSubmitting
                              ? CustomProgressIndicator()
                              : DefaultButton(
                            text: 'Next',
                            action: () {
                              if (state.specificationModels.length<=0) {
                                showSnackBar(
                                    context,
                                    Exception(
                                        'Add Product Specification Continue'));
                              }else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                        value: context.read<AddProductBloc>(),
                                        child: AddProductView4(),
                                      ),
                                    ));
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
