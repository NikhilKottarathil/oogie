import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/adapters/cart_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_blue.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/functions/show_snack_bar.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/screens/shopping/cart/cart_bloc.dart';
import 'package:oogie/screens/shopping/cart/cart_event.dart';
import 'package:oogie/screens/shopping/cart/cart_state.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: defaultAppBarBlue(context: buildContext, text: 'Shopping Cart'),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) async {
          Exception e = state.actionErrorMessage;
          if (e != null && e.toString().length != 0) {
            showSnackBar(context, e);
          }
        },
        child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          return Container(
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                // appBar: AppBar(
                //   backgroundColor: Colors.white,
                //   elevation: 2,
                //   shadowColor: AppColors.SkyLightest.withOpacity(.5),
                //   title:
                // ),
                appBar: TabBar(
                  unselectedLabelColor: AppColors.TextSubdued,
                  labelColor: AppColors.TextDefault,
                  labelStyle: TextStyles.smallRegular,
                  indicatorColor: AppColors.PrimaryBase,
                  indicatorSize: TabBarIndicatorSize.values[1],
                  tabs: [
                    Tab(
                      icon: Text(
                        "Oogie",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Tab(
                        icon: Text(
                      "Used Phones",
                      style: TextStyle(fontSize: 18),
                    )),
                  ],
                ),
                body: TabBarView(
                  children: [
                    state.newProductModels.length == 0
                        ? Center(
                            child: Text(
                            'Your cart is empty',
                            style: TextStyles.mediumMediumSubdued,
                          ))
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.newProductModels.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CartAdapter(
                                productModel: state.newProductModels[index],
                                deleteAction: () {
                                  removeFromCart(
                                      buildContext: context,
                                      productModel:
                                          state.newProductModels[index],
                                      index: index,
                                      cartType: 'new');
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 20,
                              );
                            },
                          ),
                    state.usedProductModels.length == 0
                        ? Center(
                            child: Text(
                            'Your cart is empty',
                            style: TextStyles.mediumMediumSubdued,
                          ))
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.usedProductModels.length,
                            itemBuilder: (BuildContext context, int index) {
                              return CartAdapter(
                                productModel: state.usedProductModels[index],
                                deleteAction: () {
                                  removeFromCart(
                                      buildContext: context,
                                      productModel:
                                          state.usedProductModels[index],
                                      index: index,
                                      cartType: 'used');
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 20,
                              );
                            },
                          ),
                  ],
                ),
                bottomNavigationBar: state.newProductModels.length != 0
                    ? DefaultButton(
                        text: 'Proceed to Checkout',
                        action: () {
                          List<String> productIds = [];
                          state.newProductModels.forEach((element) {
                            productIds.add(element.id.toString());
                          });
                          Navigator.pushNamed(context, '/checkout', arguments: {
                            'parenPage': 'cart',
                            'productIds': productIds
                          });
                        },
                      )
                    : null,
              ),
            ),
          );
        }),
      ),
    );
  }
}

removeFromCart(
    {BuildContext buildContext,
    ProductModel productModel,
    int index,
    String cartType}) async {
  await showModalBottomSheet(
      context: buildContext,
      enableDrag: false,
      useRootNavigator: true,
      isScrollControlled: false,
      // constraints: BoxConstraints(
      //   maxHeight: MediaQuery.of(buildContext).size.height - 30,
      // ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (builder) {
        return BlocProvider.value(
          value: buildContext.read<CartBloc>(),
          child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 64,
                        height: 64,
                        child: Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(3.0),
                              child: productModel.imageUrl != null
                                  ? Image.network(productModel.imageUrl,
                                      fit: BoxFit.scaleDown)
                                  : SvgPicture.asset(Urls().productImage,
                                      fit: BoxFit.scaleDown)),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Remove from cart ?',
                            style: TextStyles.largeRegular,
                          ),
                          Text(
                            productModel.displayName,
                            style: TextStyles.smallRegularSubdued,
                          ),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          color: AppColors.TextDefault,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              width: 1.0,
                              color: AppColors.BorderDefault,
                              style: BorderStyle.solid,
                            ),
                          ),
                          onPressed: () {
                            buildContext.read<CartBloc>().add(
                                RemoveProductFromCart(
                                    cartType: cartType, index: index));
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                              padding: EdgeInsets.all(14),
                              child: Text(' Delete ',
                                  style: TextStyles.smallMedium))),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.PrimaryBase),
                          child: Padding(
                              padding: EdgeInsets.all(14),
                              child: Text(
                                'Move to Wishlist',
                                style: TextStyles.smallMediumWhite,
                              )),
                          onPressed: () {
                            buildContext.read<CartBloc>().add(
                                MoveProductToWishList(
                                    cartType: cartType, index: index));
                            Navigator.of(context).pop();
                          },
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
        );
      });
}
