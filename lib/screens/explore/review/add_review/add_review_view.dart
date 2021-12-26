import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:oogie/adapters/my_order_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/delivery_order_Model.dart';
import 'package:oogie/screens/explore/review/add_review/add_review_cubit.dart';
import 'package:oogie/screens/explore/review/add_review/add_review_state.dart';

class AddReviewView extends StatelessWidget {
  DeliveryOrderModel deliveryOrderModel;
  int orderIndex, productIndex;

  final _formKey = GlobalKey<FormState>();

  AddReviewView({this.productIndex, this.orderIndex, this.deliveryOrderModel});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Review Product'),
      body: BlocListener<AddReviewCubit, AddReviewState>(
        listener: (context, state) {
          if (state is ErrorMessageState) {
            showSnackBar(context, state.e);
          }
          if (state is SubmissionSuccess) {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          width: width,
          height: height,
          child: LayoutBuilder(builder: (context, constraints) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minWidth: constraints.maxWidth,
                        minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20, right: 20.0),
                            child: MyOrderProductAdapter(
                              isListView: false,
                              productModel:
                                  deliveryOrderModel.products[productIndex],
                            ),
                          ),
                          dividerDefault,
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20,),
                                  Text('Rate the product',style: TextStyles.smallRegularSubdued,),
                                  SizedBox(height: 10,),

                                  BlocBuilder<AddReviewCubit, AddReviewState>(
                                    buildWhen: (prevState, state) {
                                      return state is RatingChanged ||
                                          state is InitialState;
                                    },
                                    builder: (context, state) {
                                      return RatingBar.builder(
                                        initialRating: 0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: false,
                                        itemCount: 5,
                                        unratedColor: AppColors.SkyLight,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: AppColors.GreenLight,
                                        ),
                                        onRatingUpdate: (rating) {
                                          context
                                              .read<AddReviewCubit>()
                                              .reviewChanged(rating.toString());
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(height: 20,),
                                  Text('Write your review',style: TextStyles.smallRegularSubdued,),
                                  SizedBox(height: 10,),

                                  BlocBuilder<AddReviewCubit, AddReviewState>(
                                    buildWhen: (prevState, state) {
                                      return state is ReviewChanged ||
                                          state is InitialState;
                                    },
                                    builder: (context, state) {
                                      return CustomTextField2(
                                        maxLines: 12,
                                        // labelText: 'Write your review',
                                        hintText:
                                            'More detailed reviews get more visibility..',
                                        validator: (value) {
                                          return value.toString().trim().isEmpty
                                              ? 'Please fill '
                                              : null;
                                        },
                                        text: state is ReviewChanged
                                            ? state.value
                                            : '',
                                        onChange: (value) {
                                          context
                                              .read<AddReviewCubit>()
                                              .reviewChanged(value);
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                   child: BlocBuilder<AddReviewCubit, AddReviewState>(

                      builder: (context, state) {
                        return state is LoadingState ?CustomProgressIndicator(): DefaultButton(
                          text: 'Submit',
                          action: () {
                            if (_formKey.currentState.validate()) {
                              context.read<AddReviewCubit>().submitButtonPressed();
                            }
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
