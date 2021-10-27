import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/constants/styles.dart';

class AddLocation extends StatefulWidget {
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  List<String> locations = [
    'Perinathalmana',
    'Kannur',
    'Thalesseri',
    'Thaliparmaba',
    'Payyanur'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarWhite(
          context: context, text: 'Location', prefixWidget: Container()),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 12,
            ),
            Text(
              'Update Your Location',
              style: TextStyles.largeRegular,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Select a region to showcase shops around it.',
              style: TextStyles.smallRegularSubdued,
            ),
            Row(
              children: [
                Text(
                  'If your region is not listed.',
                  style: TextStyles.smallRegularSubdued,
                ),
                CustomTextButton2(
                  text: 'Explore',
                  action: () {},
                ),
              ],
            ),
            CustomTextField2(
              hintText: 'Search by Cities/Regions',
              prefixIcon: 'icons/search.svg',
            ),
            Expanded(
              child: ListView.builder(
                itemCount: locations.length,
                  padding: EdgeInsets.only(top: 16,bottom: 16),
                  itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopsNearMe(locations[index])));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'icons/location.svg',
                          height: 24,
                          width: 24,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(width: 12,),
                        Text(
                          locations[index],
                          style: TextStyles.smallRegular,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
