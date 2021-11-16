import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oogie/adapters/product_landscape_adapter_2.dart';
import 'package:oogie/adapters/product_portrait_adapter_2.dart';
import 'package:oogie/components/radio_buttons.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/common/products/product_filter/filter_and_sort.dart';
class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController textEditingController = TextEditingController();
  List<RadioModel> radioModels = [
    // RadioModel(isSelected: true, text: 'All'),
    // RadioModel(isSelected: false, text: 'Mobiles'),
    // RadioModel(isSelected: false, text: 'Accessories'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 6.0, bottom: 6),
          child: Material(
            color: AppColors.White,
            borderRadius: BorderRadius.circular(8),
            child: TextFormField(
              maxLines: 1,
              controller: textEditingController,
              onChanged: (text) {
                setState(() {});
              },
              style: TextStyles.smallRegular,
              decoration: new InputDecoration(
                hintText: 'Search for mobiles and accessories',
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(10),
                suffixIcon: textEditingController.text.trim() == ''
                    ? null
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            textEditingController.text = '';

                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          color: AppColors.OutlinedIcon,
                          size: 25,
                        ),
                      ),
                hintStyle: TextStyles.smallRegularSubdued,
                prefixIcon: SvgPicture.asset(
                  'icons/search.svg',
                  color: AppColors.TextDefault,
                  fit: BoxFit.scaleDown,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColors.BorderDefault, width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),

                enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide: new BorderSide(
                        color: AppColors.BorderDisabled, width: 1.0)),
                //fillColor: Colors.green
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Visibility(
            visible: textEditingController.text == '',
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 12, bottom: 12),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: radioModels.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: RadioItem(radioModels[index]),
                            onTap: () {
                              radioModels.forEach(
                                  (element) => element.isSelected = false);
                              radioModels[index].isSelected = true;

                              setState(() {});
                            },
                          );
                        }),
                  ),
                  dividerDefault,
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 16, bottom: 20),
                      shrinkWrap: true,
                      children: [
                        ProductLandscapeAdapter2(
                            price: "10030",
                            brandName: 'Redmi',
                            productName:
                                'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
                            rating: '4',
                            imageUrl:
                                'https://www.gizbot.com/images/2019-07/vivo-s1_156352984560.jpg'),
                        ProductLandscapeAdapter2(
                            price: "10030",
                            brandName: 'Redmi',
                            productName:
                                'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
                            rating: '4',
                            imageUrl:
                                'https://www.gizbot.com/images/2019-07/vivo-s1_156352984560.jpg'),
                        ProductLandscapeAdapter2(
                            price: "10030",
                            brandName: 'Redmi',
                            productName:
                                'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
                            rating: '4',
                            imageUrl:
                                'https://www.gizbot.com/images/2019-07/vivo-s1_156352984560.jpg'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Visibility(
            visible: textEditingController.text != '',
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 12, bottom: 12, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Search Results:',
                          style: TextStyles.displayMedium,
                        ),
                        InkWell(
                          onTap: () {
                            filterAndSort(buildContext: context);
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.BorderDefault),
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
                        ),
                      ],
                    ),
                  ),
                  dividerDefault,
                  Expanded(
                    child: GridView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(20),
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
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
