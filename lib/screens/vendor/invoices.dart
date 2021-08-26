import 'package:flutter/material.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/screens/vendor/add_product.dart';
import 'package:oogie/screens/vendor/components/product_adapter.dart';

import 'components/invoice_adapter.dart';
import 'components/order_adapter.dart';

class Invoices extends StatefulWidget {
  @override
  _InvoicesState createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
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
                  InvoiceAdapter(),
                  InvoiceAdapter(),
                  InvoiceAdapter(),
                  InvoiceAdapter(),
                  InvoiceAdapter(),
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
