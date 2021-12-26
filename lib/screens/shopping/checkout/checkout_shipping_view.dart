import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/address_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/shopping/cart_details_view.dart';
import 'package:oogie/screens/shopping/checkout/checkout_bloc.dart';
import 'package:oogie/screens/shopping/checkout/checkout_payment_selection_view.dart';
import 'package:oogie/screens/shopping/checkout/checkout_state.dart';
import 'package:oogie/special_components/stepper_horizontal.dart';

class CheckoutShippingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Checkout'),
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: edgePadding,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 120,
                          child: StepperHorizontal(0),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<CheckoutBloc, CheckoutState>(
                            builder: (context, state) {
                          return Column(children: [
                            state.addressModel != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Shipping to: ',
                                        style:
                                            TextStyles.smallMediumPrimaryLight,
                                      ),
                                      AddressAdapter(
                                        addressModel: state.addressModel,
                                        parentPage: 'checkout',
                                      ),
                                    ],
                                  )
                                : Container(),
                            SizedBox(
                              height: 20,
                            ),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, '/addressList', arguments: {
                                  'parentPage': 'checkout',
                                  'checkoutBloc': context.read<CheckoutBloc>()
                                });
                              },
                              child: SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(14),
                                    child: Text(
                                      state.addressModel != null
                                          ? 'Change Address'
                                          : 'Add Address',
                                      style: TextStyles.smallMedium,
                                    ),
                                  ),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  width: 1.0,
                                  color: AppColors.PrimaryBase,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ]);
                        }),
                        SizedBox(
                          height: 30,
                        ),
                        CartDetailsView(
                          buildContext: context,
                        ),
                        Spacer(),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: BlocBuilder<CheckoutBloc, CheckoutState>(
                  builder: (context, state) {
                    return DefaultButton(
                      active: state.addressModel != null,
                      text: 'Continue to Payment',
                      action: () {
                        if (state.addressModel != null) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<CheckoutBloc>(),
                                child: CheckoutPaymentSelectionView(),
                              ),
                            ),
                          );
                        }
                      },
                    );
                  },
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
