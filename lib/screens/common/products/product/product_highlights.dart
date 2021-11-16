import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

class ProductHighlights extends StatelessWidget {
  List<String> highlights;

  ProductHighlights({Key key, this.highlights}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Highlights',
            style: TextStyles.smallMedium,
          ),
          SizedBox(
            height: 16,
          ),
          Column(
            children: List.generate(
                highlights.length,
                (index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 25, right: 10),
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                        ),
                        Text(
                          highlights[index],
                          style: TextStyles.smallRegular,
                        )
                      ],
                    )),
          )
        ],
      ),
    );
  }
}
