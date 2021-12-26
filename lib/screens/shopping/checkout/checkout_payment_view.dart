import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/cart_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/popups_loaders/custom_progress_indicator.dart';
import 'package:oogie/components/ui_widgets/button_with_icon.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/shopping/checkout/checkout_bloc.dart';
import 'package:oogie/screens/shopping/checkout/checkout_event.dart';
import 'package:oogie/screens/shopping/checkout/checkout_order_confirmation.dart';
import 'package:oogie/screens/shopping/checkout/checkout_review_view.dart';
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
  String paymentFailedMessage;

  void _handlePaymentSuccess(PaymentSuccessResponse paymentSuccessResponse) async {
    // Do something when payment succeeds
    print('zzzzzzzzzzzzzzzzzzzzz Success');
    print(paymentSuccessResponse);
    print(paymentSuccessResponse.signature);
    print(paymentSuccessResponse.paymentId);
    print(paymentSuccessResponse.orderId);
    paymentResponse = paymentSuccessResponse;
    context
        .read<CheckoutBloc>()
        .add(OrderStatusChanged(orderStatus: OrderStatus.PaymentSuccess));
    context
        .read<CheckoutBloc>()
        .add(CreateInvoice(transactionId: paymentSuccessResponse.orderId));
  }

  Future<void> _handlePaymentError(PaymentFailureResponse response) async {
    // Do something when payment fails
    print('zzzzzzzzzzzzzzzzzzzzz Fail');
    var body = json.decode(response.message);
    print(body);
    paymentFailedMessage = body['error']['description'];

    context
        .read<CheckoutBloc>()
        .add(OrderStatusChanged(orderStatus: OrderStatus.PaymentFailed));
  }

  Future<void> _checkOut() async {
    var options = {
      'key': Urls().razorPayApiKry,
      'amount': context.read<CheckoutBloc>().state.total * 100,
      'name': 'Oogie Shopiee',
      'description': context.read<CheckoutBloc>().orderId,
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
    _checkOut();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Checkout'),
      body:     BlocListener<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state.orderStatus == OrderStatus.InvoiceSuccess){
            context
                .read<CheckoutBloc>()
                .add(ConfirmOrder());
          }
          if (state.orderStatus == OrderStatus.OrderConfirmCompleted){
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<CheckoutBloc>(),
                  child: CheckoutConfirmationView(),
                ),
              ),
            );          }
        },
        child: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            return  Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(visible:state.orderStatus ==OrderStatus.OrderConfirming || state.orderStatus ==OrderStatus.InvoiceCreating || state.orderStatus ==OrderStatus.PaymentProcessing,child: CustomProgressIndicator()),

                Visibility(
                  visible: state.orderStatus == OrderStatus.PaymentFailed,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Payment is Failed',
                        style: TextStyles.largeRegular,),
                        Container(
                            margin: EdgeInsets.only(
                                left: 25, top: 25, bottom: 15, right: 25),
                            child: new Text(
                              "$paymentFailedMessage",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.InkBase),
                            )),
                        DefaultButton(
                          text: 'Retry',
                          action: () {
                            _checkOut();
                          },
                        ),
                        CustomTextButton(
                          text: 'Exit',
                          action: () {
                            // for (int i = 0; i < widget.popCount + 1; i++) {
                              Navigator.of(context).pop();
                            // }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: state.orderStatus == OrderStatus.InvoiceFailed || state.orderStatus == OrderStatus.OrderConfirmFailed,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Your order is not placed",
                          style: TextStyles.largeRegular,),
                        Container(
                            margin: EdgeInsets.only(
                                left: 25, top: 25, bottom: 15, right: 25),
                            child: new Text(
                              "The payment has been completed, your order is not placed,please retry to continue or the amount will be refunded if you cancel",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.InkBase),
                            )),
                        DefaultButton(
                          text: 'Retry',
                          action: () {
                            if(state.orderStatus == OrderStatus.InvoiceFailed) {
                              context
                                  .read<CheckoutBloc>()
                                  .add(CreateInvoice());
                            }else if(state.orderStatus == OrderStatus.OrderConfirmFailed){
                              context
                                  .read<CheckoutBloc>()
                                  .add(ConfirmOrder());
                            }},
                        ),
                        CustomTextButton(
                          text: 'Cancel',
                          action: () {
                            // for (int i = 0; i < widget.popCount + 1; i++) {
                            Navigator.of(context).pop();
                            // }
                          },
                        ),
                      ],
                    ),
                  ),
                )




              ],
            );

          },
        ),
      ),
    );
  }
}
