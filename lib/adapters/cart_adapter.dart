import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/product_model.dart';
import 'package:oogie/screens/shopping/checkout/checkout_bloc.dart';
import 'package:oogie/screens/shopping/checkout/checkout_event.dart';

class CartAdapter extends StatefulWidget {
  ProductModel productModel;
  Function deleteAction;
  String parentPage;
  CheckoutBloc checkoutBloc;

  CartAdapter(
      {this.productModel,
      this.deleteAction,
      this.parentPage,
      this.checkoutBloc});

  @override
  _CartAdapterState createState() => _CartAdapterState();
}

class _CartAdapterState extends State<CartAdapter> {
  ProductModel productModel;

  String parentPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.parentPage == null) {
      parentPage = widget.parentPage;
    } else {
      parentPage = '';
    }
    productModel = widget.productModel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: edgePadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, 'product',
                      arguments: {'id': productModel.id, 'parentPage': 'cart'});
                },
                child: SizedBox(
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
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text(
                          productModel.displayName,
                          style: TextStyles.smallRegular,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                        widget.deleteAction != null
                            ? IconButton(
                                icon: SvgPicture.asset('icons/delete.svg'),
                                splashColor: Colors.transparent,
                                onPressed: () {
                                  widget.deleteAction();
                                })
                            : Container(),
                      ],
                    ),
                    Text(
                      productModel.brandName,
                      style: TextStyles.smallRegularSubdued,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Qty:',
                              style: TextStyles.smallRegular,
                            ),
                            Row(
                              children: [
                                widget.parentPage != 'payment'
                                    ? IconButton(
                                        icon: SvgPicture.asset(
                                            'icons/minus_square.svg'),
                                        splashColor: Colors.transparent,
                                        onPressed: () {
                                          if (productModel.qty > 1) {
                                            productModel.qty -= 1;
                                            productModel.totalPrice =
                                                double.parse(productModel.qty
                                                        .toString()) *
                                                    double.parse(productModel
                                                        .unitPrice
                                                        .toString());
                                            // if(widget.checkoutBloc!=null){
                                            //   widget.checkoutBloc.add(QtyUpdated());
                                            // }
                                            setState(() {});
                                          }
                                        })
                                    : Container(
                                        width: 10,
                                      ),
                                Text(
                                  productModel.qty.toString(),
                                  style: TextStyles.mediumRegular,
                                ),
                                widget.parentPage != 'payment'
                                    ? IconButton(
                                        icon: SvgPicture.asset(
                                            'icons/plus_square.svg'),
                                        splashColor: Colors.transparent,
                                        onPressed: () {
                                          productModel.qty += 1;
                                          productModel
                                              .totalPrice = double.parse(
                                                  productModel.qty.toString()) *
                                              double.parse(productModel
                                                  .unitPrice
                                                  .toString());
                                          if (widget.checkoutBloc != null) {
                                            widget.checkoutBloc
                                                .add(QtyUpdated());
                                          }
                                          setState(() {});
                                        })
                                    : Container(),
                              ],
                            )
                          ],
                        ),
                        Text(
                          productModel.totalPrice.toStringAsFixed(2),
                          style: TextStyles.smallMedium,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: AppColors.DividerBase,
          thickness: 1,
        )
      ],
    );
  }
}
