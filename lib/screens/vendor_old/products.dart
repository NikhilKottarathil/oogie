import 'package:flutter/material.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/screens/vendor_old/add_product.dart';
import 'package:oogie/screens/vendor_old/components/product_adapter.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 20),
        child: Column(
          children: [
            CustomTextField2(
              prefixIcon: 'icons/search.svg',
              hintText: 'Search',
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  ProductAdapter(
                      price: "10030",
                      brandName: 'Redmi',
                      productName: 'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
                      rating: '4',
                      imageUrl:
                          'https://www.gizbot.com/images/2019-07/vivo-s1_156352984560.jpg'),
                  ProductAdapter(
                      price: "10030",
                      brandName: 'Redmi',
                      productName: 'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
                      rating: '4',
                      imageUrl:
                          'https://www.gizbot.com/images/2019-07/vivo-s1_156352984560.jpg'),
                  ProductAdapter(
                      price: "10030",
                      brandName: 'Redmi',
                      productName: 'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
                      rating: '4',
                      imageUrl:
                          'https://www.gizbot.com/images/2019-07/vivo-s1_156352984560.jpg'),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddProduct(
                    title: 'Add Product',
                  )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
