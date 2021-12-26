import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/my_order_adapter.dart';
import 'package:oogie/adapters/order_details_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/ui_widgets/custom_dropdown.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/delivery_order_Model.dart';
import 'package:oogie/models/order_model.dart';
import 'package:oogie/screens/user/orders/order_return_request/order_return_request_cubit.dart';
import 'package:oogie/screens/user/orders/order_return_request/order_return_request_state.dart';
import 'package:oogie/special_components/image_picker_grid.dart';

class OrderReturnRequestView extends StatelessWidget {
  DeliveryOrderModel deliveryOrderModel;
  int orderIndex, productIndex;

  final _formKey = GlobalKey<FormState>();

  OrderReturnRequestView(
      {this.productIndex, this.orderIndex, this.deliveryOrderModel});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Request Return'),
      body: BlocListener<OrderReturnRequestCubit, OrderReturnRequestState>(
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
                            padding: EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 10),
                            child: Text(
                              'Order ID - ${deliveryOrderModel.id}',
                              style: TextStyles.smallRegularSubdued,
                            ),
                          ),
                          dividerDefault,
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
                                  SizedBox(
                                    height: 30,
                                  ),
                                  BlocBuilder<OrderReturnRequestCubit,
                                          OrderReturnRequestState>(
                                      buildWhen: (prevState, state) {
                                    return state is LoadReasons ||
                                        state is InitialState;
                                  }, builder: (context, state) {
                                    return state is LoadReasons
                                        ? CustomDropdown(
                                            titleText: 'Reason for return',
                                            items: state.models
                                                .map((e) => e.text)
                                                .toList(),
                                            selected: state.models
                                                .singleWhere(
                                                    (e) => e.isSelected)
                                                .text,
                                            action: (String newValue) {
                                              context
                                                  .read<
                                                      OrderReturnRequestCubit>()
                                                  .reasonSelected(newValue);
                                            },
                                          )
                                        : Container();
                                  }),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Capture Product Image',
                                    style: TextStyles.smallRegular,
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Note: Any instruction about capturing image goes here',
                                    style: TextStyles.tinyRegularSubdued,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  BlocBuilder<OrderReturnRequestCubit,
                                          OrderReturnRequestState>(
                                      buildWhen: (prevState, state) {
                                    return state is LoadPhotos ||
                                        state is InitialState;
                                  }, builder: (context, state) {
                                    return state is LoadPhotos
                                        ? SizedBox(
                                            height: ((width - 40) / 3),
                                            child: ImagePickerGrid(
                                                imageFiles: state.models,
                                                action: (int index) {
                                                  context
                                                      .read<
                                                          OrderReturnRequestCubit>()
                                                      .addPhotos(
                                                          context, index);
                                                }))
                                        : SizedBox(
                                            height: ((width - 40) / 3),
                                            child: ImagePickerGrid(
                                              imageFiles: [],
                                              action: (int index) {
                                                context
                                                    .read<
                                                        OrderReturnRequestCubit>()
                                                    .addPhotos(context, index);
                                              },
                                            ));
                                  }),
                                  BlocBuilder<OrderReturnRequestCubit,
                                          OrderReturnRequestState>(
                                      buildWhen: (prevState, state) {
                                    return state is BankNameChanged ||
                                        state is InitialState;
                                  }, builder: (context, state) {
                                    return CustomTextField2(
                                      labelText: 'Account Number',
                                      hintText: '0000 0000 0000 0000',
                                      validator: (value) {
                                        return value.toString().trim().isEmpty
                                            ? 'Please fill '
                                            : context
                                                .read<OrderReturnRequestCubit>()
                                                .validateAccountNumberText;
                                      },
                                      text: state is AccountNumberChanged
                                          ? state.value
                                          : '',
                                      onChange: (value) {
                                        context
                                            .read<OrderReturnRequestCubit>()
                                            .accountNumberChanged(value);
                                      },
                                    );
                                  }),
                                  BlocBuilder<OrderReturnRequestCubit,
                                          OrderReturnRequestState>(
                                      buildWhen: (prevState, state) {
                                    return state is BankNameChanged ||
                                        state is InitialState;
                                  }, builder: (context, state) {
                                    return CustomTextField2(
                                      labelText: 'Confirm Account Number',
                                      hintText: '0000 0000 0000 0000',
                                      validator: (value) {
                                        return value.toString().trim().isEmpty
                                            ? 'Please fill '
                                            : context
                                                .read<OrderReturnRequestCubit>()
                                                .validateAccountNumberText;
                                      },
                                      text: state is VerifyAccountNumberChanged
                                          ? state.value
                                          : '',
                                      onChange: (value) {
                                        context
                                            .read<OrderReturnRequestCubit>()
                                            .verifyAccountNumberChanged(value);
                                      },
                                    );
                                  }),
                                  BlocBuilder<OrderReturnRequestCubit,
                                          OrderReturnRequestState>(
                                      buildWhen: (prevState, state) {
                                    return state is BankNameChanged ||
                                        state is InitialState;
                                  }, builder: (context, state) {
                                    return CustomTextField2(
                                      labelText: 'IFSC Code',
                                      hintText: 'IFSC000000',
                                      validator: (value) {
                                        return value.toString().trim().isEmpty
                                            ? 'Please fill '
                                            : null;
                                      },
                                      text: state is IFSCChanged
                                          ? state.value
                                          : '',
                                      onChange: (value) {
                                        context
                                            .read<OrderReturnRequestCubit>()
                                            .ifscChanged(value);
                                      },
                                    );
                                  }),
                                  BlocBuilder<OrderReturnRequestCubit,
                                          OrderReturnRequestState>(
                                      buildWhen: (prevState, state) {
                                    return state is BankNameChanged ||
                                        state is InitialState;
                                  }, builder: (context, state) {
                                    return CustomTextField2(
                                      labelText: 'Bank Name',
                                      hintText: 'Bank Name',
                                      validator: (value) {
                                        return value.toString().trim().isEmpty
                                            ? 'Please fill'
                                            : null;
                                      },
                                      text: state is BankNameChanged
                                          ? state.value
                                          : '',
                                      onChange: (value) {
                                        context
                                            .read<OrderReturnRequestCubit>()
                                            .bankNameChanged(value);
                                      },
                                    );
                                  }),
                                  BlocBuilder<OrderReturnRequestCubit,
                                          OrderReturnRequestState>(
                                      buildWhen: (prevState, state) {
                                    return state is BankNameChanged ||
                                        state is InitialState;
                                  }, builder: (context, state) {
                                    return CustomTextField2(
                                      labelText: 'Bank Branch',
                                      hintText: 'Bank Branch',
                                      validator: (value) {
                                        return value.toString().trim().isEmpty
                                            ? 'Please fill'
                                            : null;
                                      },
                                      text: state is BankBranchChanged
                                          ? state.value
                                          : '',
                                      onChange: (value) {
                                        context
                                            .read<OrderReturnRequestCubit>()
                                            .bankBranchChanged(value);
                                      },
                                    );
                                  }),

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
                    child: DefaultButton(
                      text: 'Submit Request',
                      action: () {
                        if (_formKey.currentState.validate()) {
                          context
                              .read<OrderReturnRequestCubit>()
                              .returnSubmitted();
                        }
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
