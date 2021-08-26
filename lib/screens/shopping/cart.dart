import 'package:flutter/material.dart';
import 'package:oogie/adapters/cart_adapter.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_app_bars.dart';
import 'package:oogie/components/default_button.dart';

import 'checkout_shipping.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: defaultAppBarBlue(context: context,text: 'Shopping Cart'),
      body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      //
                      Expanded(
                        child: Wrap(
                          children: [

                            CartAdapter(productName: 'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',brandName: 'Redmi',price:rupeesString+'10000',imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',),
                          ],
                        ),
                      ),



                      // Row(
                      //
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text("Total 2 items",style: AppStyles.tinyBold,),
                      //     Text(rupeesString+' '+'26999',style: AppStyles.smallBold,),
                      //   ],
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: DefaultButton(action: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckoutShipping()));
                        },
                        text: 'Proceed to Checkout',),
                      )

                    ],
                  ),
                ),
              ),
            );
          }),

    );
  }
}
