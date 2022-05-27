import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/my_order_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/popups_loaders/alert_bottom_sheet.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/address_model.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/screens/common/order_details/order_details_cubit.dart';
import 'package:oogie/screens/common/order_details/order_details_state.dart';
import 'package:oogie/screens/common/vendor_sale_report/generate_pdf.dart';
import 'package:oogie/screens/explore/review/add_review/add_review_cubit.dart';
import 'package:oogie/screens/explore/review/add_review/add_review_view.dart';
import 'package:oogie/screens/user/orders/order_return_request/order_return_request_cubit.dart';
import 'package:oogie/screens/user/orders/order_return_request/order_return_request_view.dart';
import 'package:oogie/special_components/stepper_vertical.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Order Details'),
      body: BlocListener<OrderDetailsCubit, OrderDetailsState>(
        listener: (context, state) {
          if (state is ErrorMessageState) {
            showSnackBar(context, state.e);
          }
        },
        child: BlocBuilder<OrderDetailsCubit, OrderDetailsState>(
            buildWhen: (prevState, state) {
          return state is OrderDataState || state is InitialState;
        }, builder: (context, state) {
          return state is OrderDataState
              ? Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20, left: 20, right: 20, bottom: 10),
                            child: Text(
                              'Order ID - ${state.deliveryOrderModel.id}',
                              style: TextStyles.smallRegularSubdued,
                            ),
                          ),
                          dividerDefault,
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: MyOrderProductAdapter(
                                productModel:
                                    state.deliveryOrderModel.products[0],
                                isListView: false,
                              )),
                          dividerDefault,
                          StepperVertical(
                              deliveryStatuses:
                                  state.deliveryOrderModel.deliveryStatuses,
                              deliveryState:
                                  state.deliveryOrderModel.deliveryState,
                              parentPage:
                                  context.read<OrderDetailsCubit>().parentPage,
                              reviewId: state.deliveryOrderModel.reviewId,
                              reviewAction: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (_) => AddReviewCubit(
                                          orderRepository: orderRepository,
                                          parentPage: 'orderDetails',
                                          deliveryOrderModel: context
                                              .read<OrderDetailsCubit>()
                                              .deliveryOrderModel,
                                          orderDetailsCubit:
                                              context.read<OrderDetailsCubit>(),
                                          productIndex: 0),
                                      child: AddReviewView(
                                        productIndex: 0,
                                        deliveryOrderModel: context
                                            .read<OrderDetailsCubit>()
                                            .deliveryOrderModel,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          dividerDefault,
                          Visibility(
                            visible:
                                context.read<OrderDetailsCubit>().parentPage ==
                                    'deliveryPartnerOrders',
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 12, bottom: 12),
                              child: pickingAddressAddressWidget(context,
                                  state.deliveryOrderModel.pickingAddressModel),
                            ),
                          ),
                          dividerDefault,
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 12, bottom: 12),
                            child: deliveryAddressWidget(context,
                                state.deliveryOrderModel.shippingAddressModel),
                          ),
                          Visibility(
                            visible:
                                context.read<OrderDetailsCubit>().parentPage ==
                                    'myOrders',
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/originalOrder', arguments: {
                                  'orderId': state.deliveryOrderModel.orderId,
                                  'parentPage': 'orderDetails'
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Center(
                                        child: Text(
                                      'View Original Order',
                                      style: TextStyles.mediumMediumSubdued,
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible:
                                context.read<OrderDetailsCubit>().parentPage ==
                                    'vendorOrders',
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onTap: () {
                               PDF pdf=PDF();
                               pdf.generateBillInvoice(deliveryOrderModel: state.deliveryOrderModel);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Center(
                                        child: Text(
                                      'Download Bill Invoice',
                                      style: TextStyles.mediumMediumSubdued,
                                    )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // deliveryAddress(),
                            Visibility(
                              visible: context
                                  .read<OrderDetailsCubit>()
                                  .buttonVisibility,
                              child: DefaultButton(
                                text: context
                                    .read<OrderDetailsCubit>()
                                    .buttonText,
                                action: () {
                                  context
                                              .read<OrderDetailsCubit>()
                                              .buttonText ==
                                          'Return'
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => BlocProvider(
                                                  create: (_) => OrderReturnRequestCubit(
                                                      orderRepository:
                                                          orderRepository,
                                                      parentPage:
                                                          'myOrderDetailView',
                                                      deliveryOrderModel: state
                                                          .deliveryOrderModel,
                                                      orderDetailsCubit:
                                                          context.read<
                                                              OrderDetailsCubit>()),
                                                  child: OrderReturnRequestView(
                                                    deliveryOrderModel: state
                                                        .deliveryOrderModel,
                                                    productIndex: 0,
                                                  ))))
                                      : showAlertBottomSheet(
                                          context: context,
                                          // heading: 'Heading',
                                          content:
                                              'Are you sure to ${context.read<OrderDetailsCubit>().buttonText} the order',
                                          positiveAction: () {
                                            context
                                                .read<OrderDetailsCubit>()
                                                .buttonPressed();
                                            Navigator.pop(context);
                                          });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }

  Widget deliveryAddressWidget(
      BuildContext context, AddressModel addressModel) {
    return addressModel != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivery Address',
                style: TextStyles.smallRegularSubdued,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                addressModel.name,
                style: TextStyles.smallMedium,
              ),
              Text(
                addressModel.address1,
                style: TextStyles.smallRegularSubdued,
              ),
              Text(
                addressModel.address2,
                style: TextStyles.smallRegularSubdued,
              ),
              Text(
                addressModel.landmark,
                style: TextStyles.smallRegularSubdued,
              ),
              Text(
                addressModel.city,
                style: TextStyles.smallRegularSubdued,
              ),
              Text(
                addressModel.pinCode + ', ' + addressModel.state,
                style: TextStyles.smallRegularSubdued,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Text(addressModel.phoneNumber,
                          style: TextStyles.smallMedium),
                      SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: context.read<OrderDetailsCubit>().parentPage !=
                            'myOrders',
                        child: InkWell(
                            onTap: () async {
                              final Uri _phoneUri = Uri(
                                  scheme: "tel",
                                  path: addressModel.phoneNumber);
                              try {
                                if (await canLaunch(_phoneUri.toString()))
                                  await launch(_phoneUri.toString());
                              } catch (error) {
                                showSnackBar(
                                    context, Exception(["Cannot dial"]));
                              }
                            },
                            child: Icon(
                              Icons.call,
                              size: 16,
                              color: AppColors.GreenLight,
                            )),
                      )
                    ],
                  ),
                  SizedBox(width: 10,),
                  Row(
                    children: [
                      Text(addressModel.alternativePhoneNumber,
                          style: TextStyles.smallMedium),
                      SizedBox(
                        width: 5,
                      ),
                      Visibility(
                        visible: context.read<OrderDetailsCubit>().parentPage !=
                            'myOrders',
                        child: InkWell(
                            onTap: () async {
                              final Uri _phoneUri = Uri(
                                  scheme: "tel",
                                  path: addressModel.alternativePhoneNumber);
                              try {
                                if (await canLaunch(_phoneUri.toString()))
                                  await launch(_phoneUri.toString());
                              } catch (error) {
                                showSnackBar(
                                    context, Exception(["Cannot dial"]));
                              }
                            },
                            child: Icon(
                              Icons.call,
                              size: 16,
                              color: AppColors.GreenLight,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ],
          )
        : Container();
  }

  Widget pickingAddressAddressWidget(
      BuildContext context, AddressModel addressModel) {
    return addressModel != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Picking Address',
                style: TextStyles.smallRegularSubdued,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                addressModel.name,
                style: TextStyles.smallMedium,
              ),
              Text(
                addressModel.address1,
                style: TextStyles.smallRegularSubdued,
              ),
              Text(
                addressModel.address2,
                style: TextStyles.smallRegularSubdued,
              ),
              addressModel.landmark != null
                  ? Text(
                      addressModel.landmark,
                      style: TextStyles.smallRegularSubdued,
                    )
                  : Container(),
              Text(
                addressModel.city,
                style: TextStyles.smallRegularSubdued,
              ),
              Text(
                addressModel.pinCode + ', ' + addressModel.state,
                style: TextStyles.smallRegularSubdued,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Text(addressModel.phoneNumber,
                          style: TextStyles.smallMedium),
                      SizedBox(
                        width: 5,
                      ),
                      Visibility(
                        visible: context.read<OrderDetailsCubit>().parentPage !=
                            'myOrders',
                        child: InkWell(
                            onTap: () async {
                              final Uri _phoneUri = Uri(
                                  scheme: "tel",
                                  path: addressModel.phoneNumber);
                              try {
                                if (await canLaunch(_phoneUri.toString()))
                                  await launch(_phoneUri.toString());
                              } catch (error) {
                                showSnackBar(
                                    context, Exception(["Cannot dial"]));
                              }
                            },
                            child: Icon(
                              Icons.call,
                              size: 16,
                              color: AppColors.GreenLight,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )
        : Container();
  }
}
