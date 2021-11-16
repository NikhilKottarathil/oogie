import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/cart_adapter.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/shopping/checkout/checkout_bloc.dart';
import 'package:oogie/screens/shopping/checkout/checkout_state.dart';

class CartDetailsView extends StatefulWidget {
  CartDetailsView({BuildContext buildContext});

  @override
  _CartDetailsViewState createState() => _CartDetailsViewState();
}

class _CartDetailsViewState extends State<CartDetailsView> {
  String showText = 'Hide cart details';
  String hideText = 'Show cart details';
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  isVisible = !isVisible;
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.SurfaceDisabled,
                      borderRadius: BorderRadius.circular(4)),
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(isVisible ? showText : hideText,
                          style: TextStyles.smallRegularPrimaryLight),
                      isVisible
                          ? Icon(
                              Icons.keyboard_arrow_up_sharp,
                              color: AppColors.OutlinedIcon,
                            )
                          : Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: AppColors.OutlinedIcon,
                            )
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: isVisible,
                child: Container(
                  color: AppColors.SurfaceDisabled.withOpacity(.6),
                  child: Column(
                    children: [
                      Wrap(
                        children:
                            List.generate(state.productModels.length, (index) {
                          return CartAdapter(
                            checkoutBloc: context.read<CheckoutBloc>(),
                            productModel: state.productModels[index],
                          );
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 20, right: 20, bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Subtotal',
                                  style: TextStyles.smallRegularSubdued,
                                ),
                                Text(
                                  rupeesString +
                                      state.subTotal.toStringAsFixed(2),
                                  style: TextStyles.smallRegularSubdued,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Shipping',
                                  style: TextStyles.smallRegularSubdued,
                                ),
                                Text(
                                    state.deliveryCharge == 0.0
                                        ? 'FREE'
                                        : state.deliveryCharge
                                            .toStringAsFixed(2),
                                    style: TextStyles.smallRegularSubdued)
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Expected Delivery',
                                  style: TextStyles.smallRegularSubdued,
                                ),
                                Text(
                                  'Apr 20 - 28',
                                  style: TextStyles.smallRegularSubdued,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Taxes',
                                  style: TextStyles.smallRegularSubdued,
                                ),
                                Text(
                                  rupeesString + state.taxes.toStringAsFixed(2),
                                  style: TextStyles.smallRegularSubdued,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyles.mediumMedium,
                                ),
                                Text(
                                  rupeesString + state.total.toStringAsFixed(2),
                                  style: TextStyles.mediumMedium,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
