import 'package:flutter/material.dart';
import 'package:oogie/adapters/product_portrait_adapter.dart';
class ProductPortraitGridView extends StatefulWidget {
  @override
  _ProductPortraitGridViewState createState() => _ProductPortraitGridViewState();
}

class _ProductPortraitGridViewState extends State<ProductPortraitGridView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 24,),
        GridView(
          shrinkWrap: true,
          padding: EdgeInsets.all(2),
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.7,crossAxisSpacing: 15,mainAxisSpacing: 15),
          children: [
            ProductPortraitAdapter(productName: 'Redmi 9 (Sky Blue, 32GB)',brandName: 'Redmi',imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',),
            ProductPortraitAdapter(productName: 'Redmi 9 (Sky Blue, 32GB)',brandName: 'Redmi',imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',),
            ProductPortraitAdapter(productName: 'Redmi 9 (Sky Blue, 32GB)',brandName: 'Redmi',imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',),
            ProductPortraitAdapter(productName: 'Redmi 9 (Sky Blue, 32GB)',brandName: 'Redmi',imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',),
          ],

        ),
      ],
    );
  }
}
