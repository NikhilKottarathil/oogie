import 'package:flutter/material.dart';
import 'package:oogie/adapters/product_landscape_adapter.dart';

class ProductLandscapeGridView extends StatefulWidget {
  @override
  _ProductLandscapeGridViewState createState() =>
      _ProductLandscapeGridViewState();
}

class _ProductLandscapeGridViewState extends State<ProductLandscapeGridView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 24,
        ),
        SizedBox(
          height: 240,
          child: GridView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(2),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, mainAxisSpacing: 15),
            children: [
              ProductLandscapeAdapter(
                productName: 'Redmi 9 (Sky Blue, 32GB)',
                brandName: 'Redmi',
                imageUrl:
                    'https://i1.wp.com/st1.bgr.in/wp-content/uploads/2020/02/Samsung-Galaxy-A51-1.jpg?ssl=1',
              ),
              ProductLandscapeAdapter(
                productName: 'Redmi 9 (Sky Blue, 32GB)',
                brandName: 'Redmi',
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',
              ),
              ProductLandscapeAdapter(
                productName: 'Redmi 9 (Sky Blue, 32GB)',
                brandName: 'Redmi',
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',
              ),
              ProductLandscapeAdapter(
                productName: 'Redmi 9 (Sky Blue, 32GB)',
                brandName: 'Redmi',
                imageUrl:
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',
              ),
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
