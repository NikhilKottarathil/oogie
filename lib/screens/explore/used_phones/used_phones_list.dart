import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/adapters/product_portrait_adapter_2.dart';
import 'package:oogie/components/app_bar/secondary_app_bar.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/explore/product_filter/filter_and_sort.dart';
import 'package:oogie/screens/explore/used_phones/sell_a_phone_step1.dart';

class UsedPhonesList extends StatefulWidget {
  @override
  _UsedPhonesListState createState() => _UsedPhonesListState();
}

class _UsedPhonesListState extends State<UsedPhonesList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: secondaryAppBar(context: context),
      body: Container(
        padding: edgePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Used Phones',
                  style: TextStyles.displayMedium,
                ),
                InkWell(
                  onTap: (){
                    filterAndSort(buildContext: context);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.BorderDefault),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      children: [
                        SvgPicture.asset('icons/filter.svg'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Filter',
                          style: TextStyles.smallMedium,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 11,
            ),
            dividerDefault,
            SizedBox(
              height: 14,
            ),
            GridView(
              shrinkWrap: true,
              padding: EdgeInsets.all(2),
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15),
              children: [
                ProductPortraitAdapter2(
                  productName: 'Redmi 9 (Sky Blue, 32GB)',
                  brandName: 'Redmi',
                  price: '25000',
                  rating: '3',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',
                ),
                ProductPortraitAdapter2(
                  productName: 'Redmi 9 (Sky Blue, 32GB)',
                  brandName: 'Redmi',
                  price: '25000',
                  rating: '3',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',
                ),
                ProductPortraitAdapter2(
                  productName: 'Redmi 9 (Sky Blue, 32GB)',
                  brandName: 'Redmi',
                  price: '25000',
                  rating: '3',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',
                ),
                ProductPortraitAdapter2(
                  productName: 'Redmi 9 (Sky Blue, 32GB)',
                  brandName: 'Redmi',
                  price: '25000',
                  rating: '3',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2wOfWNFDmeGDTtRze4VdbESP8XDlyC3EFKw&usqp=CAU',
                ),
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SellAPhoneStep1()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
