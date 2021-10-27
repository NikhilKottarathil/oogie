import 'package:flutter/material.dart';
import 'package:oogie/components/custom_textfield_2.dart';

import 'components/order_adapter.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 20),
        child: Column(
          children: [
            CustomTextField2(prefixIcon: 'icons/search.svg',hintText: 'Search',),
            SizedBox(height: 20,),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  OrderAdapter(),
                  OrderAdapter(),
                  OrderAdapter(),
                  OrderAdapter(),
                  OrderAdapter(),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
