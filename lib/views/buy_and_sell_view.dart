import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/explore/used_phones/used_phones_list.dart';

class BuyAndSellView extends StatefulWidget {
  @override
  _BuyAndSellViewState createState() => _BuyAndSellViewState();
}

class _BuyAndSellViewState extends State<BuyAndSellView> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => UsedPhonesList()));
      },
      child: Container(
        height: height * .35,
        width: double.infinity,
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/buy_and_sell_background.svg',
              fit: BoxFit.fill,
              height: height * .35,
              width: double.infinity,
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Buy & Sell',
                    style: TextStyles.displayMedium,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Used phones with us',
                        style: TextStyles.largeRegular,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: AppColors.SecondaryBase,
                      )
                    ],
                  ),
                  Expanded(
                      child: Center(
                          child: Image.network(
                    'https://www.phonepro.in/assets/img/intro-mobile.png',
                    height: height * .15,
                    fit: BoxFit.scaleDown,
                  )))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
