import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/cart_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/shopping/checkout/checkout_bloc.dart';
import 'package:oogie/screens/shopping/checkout/checkout_event.dart';
import 'package:oogie/screens/shopping/checkout/checkout_order_confirmation.dart';
import 'package:oogie/screens/shopping/checkout/checkout_state.dart';
import 'package:oogie/special_components/stepper_horizontal.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CheckoutPaymentView extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<CheckoutPaymentView> {
  Razorpay razorPay = Razorpay();
  PaymentSuccessResponse paymentResponse;

  void _handlePaymentSuccess(PaymentSuccessResponse paymnetResponse) async {
    // Do something when payment succeeds
    print('zzzzzzzzzzzzzzzzzzzzz Success');
    print(paymnetResponse);
    print(paymnetResponse.signature);
    print(paymnetResponse.paymentId);
    print(paymnetResponse.orderId);
    paymentResponse = paymnetResponse;
    context
        .read<CheckoutBloc>()
        .add(OrderStatusChanged(orderStatus: OrderStatus.PaymentSuccess));
  }

  Future<void> _handlePaymentError(PaymentFailureResponse response) async {
    // Do something when payment fails
    print('zzzzzzzzzzzzzzzzzzzzz Fail');
    context
        .read<CheckoutBloc>()
        .add(OrderStatusChanged(orderStatus: OrderStatus.PaymentFailed));
  }

  Future<void> _checkOut() async {
    var options = {
      'key': 'rzp_test_ggroFiTdfl4T5I',
      'amount': context.read<CheckoutBloc>().state.total * 100,
      'name': 'Oogie',
      'description': 'orderId',
      'prefill': {
        'contact': AppData().userName,
        'contact': AppData().phoneNumber,
        // 'email': widget.email,
      }
    };

    try {
      razorPay.open(options);
    } catch (e) {
      print('razor Erorrrrrr');
    }
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
    print('handle wallet');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Checkout'),
      body: LayoutBuilder(builder: (context, constraints) {
        return BlocListener<CheckoutBloc, CheckoutState>(
          listener: (context, state) {
            if (state.orderStatus == OrderStatus.OrderCreationSuccess &&
                state.paymentTypeState == PaymentTypeState.online) {
              _checkOut();
            }
          },
          child: BlocBuilder<CheckoutBloc, CheckoutState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                          minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: true
                            ? Padding(
                                padding: edgePadding,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 120,
                                      child: StepperHorizontal(1),
                                    ),
                                    Visibility(
                                      visible: true,
                                      child: Container(
                                        // color: AppColors.SurfaceDisabled.withOpacity(.6),
                                        child: Column(
                                          children: [
                                            Wrap(
                                              children: List.generate(
                                                  state.productModels.length,
                                                  (index) {
                                                return CartAdapter(
                                                  checkoutBloc: context
                                                      .read<CheckoutBloc>(),
                                                  productModel: state
                                                      .productModels[index],
                                                  parentPage: 'payment',
                                                );
                                              }),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0,
                                                  top: 20,
                                                  right: 20,
                                                  bottom: 20),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Subtotal',
                                                        style: TextStyles
                                                            .smallRegularSubdued,
                                                      ),
                                                      Text(
                                                        rupeesString +
                                                            state.subTotal
                                                                .toStringAsFixed(
                                                                    2),
                                                        style: TextStyles
                                                            .smallRegularSubdued,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Shipping',
                                                        style: TextStyles
                                                            .smallRegularSubdued,
                                                      ),
                                                      Text(
                                                          state.deliveryCharge ==
                                                                  0.0
                                                              ? 'FREE'
                                                              : state
                                                                  .deliveryCharge
                                                                  .toStringAsFixed(
                                                                      2),
                                                          style: TextStyles
                                                              .smallRegularSubdued)
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Expected Delivery',
                                                        style: TextStyles
                                                            .smallRegularSubdued,
                                                      ),
                                                      Text(
                                                        'Apr 20 - 28',
                                                        style: TextStyles
                                                            .smallRegularSubdued,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Taxes',
                                                        style: TextStyles
                                                            .smallRegularSubdued,
                                                      ),
                                                      Text(
                                                        rupeesString +
                                                            state.taxes
                                                                .toStringAsFixed(
                                                                    2),
                                                        style: TextStyles
                                                            .smallRegularSubdued,
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 12,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        'Total',
                                                        style: TextStyles
                                                            .mediumMedium,
                                                      ),
                                                      Text(
                                                        rupeesString +
                                                            state.total
                                                                .toStringAsFixed(
                                                                    2),
                                                        style: TextStyles
                                                            .mediumMedium,
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      color: AppColors.BackgroundColor,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 20, right: 20, bottom: 20),
                        child: BlocBuilder<CheckoutBloc, CheckoutState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Payment Method',
                                      style: TextStyles.smallMedium,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            Radio(
                                                value: PaymentTypeState.cod,
                                                groupValue:
                                                    state.paymentTypeState,
                                                onChanged: (value) {
                                                  context
                                                      .read<CheckoutBloc>()
                                                      .add(PaymentMethodChanged(
                                                          paymentTypeState:
                                                              value));
                                                }),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'COD',
                                              style: TextStyles.smallRegular,
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Radio(
                                                value: PaymentTypeState.online,
                                                groupValue:
                                                    state.paymentTypeState,
                                                onChanged: (value) {
                                                  context
                                                      .read<CheckoutBloc>()
                                                      .add(PaymentMethodChanged(
                                                          paymentTypeState:
                                                              value));
                                                }),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'Online',
                                              style: TextStyles.smallRegular,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                DefaultButton(
                                  active: state.paymentTypeState !=
                                          PaymentTypeState.none &&
                                      state.addressModel != null,
                                  text: 'Continue to Payment',
                                  action: () {
                                    // if (state.paymentTypeState !=
                                    //     PaymentTypeState.none &&
                                    //     state.addressModel != null) {
                                    //   context.read<CheckoutBloc>().add(OrderStatusChanged(orderStatus: OrderStatus.OrderCreating));
                                    // }
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                          value: context.read<CheckoutBloc>(),
                                          child: CheckoutConfirmationView(),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      }),
    );
  }
}
