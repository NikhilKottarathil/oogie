
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';


class SellAPhoneStep5 extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SellAPhoneStep5> {
  final List<String> imgList = [

    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRFAcpLIcZeWM_DHkAPJbazgZL20TLjXJHag&usqp=CAU',
    'https://www.zdnet.com/a/hub/i/r/2021/01/07/a20ae151-6384-47c4-a75e-802455021c41/thumbnail/1200x900/87979d415e6537a431386a8120ae95b1/apple-iphone-12-best-phones-review.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUReFEKDP0VTrMNbtpwmadyPHvI1QkDUcs8Q&usqp=CAU'
  ];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Ad Review',suffixAction: (){},suffixWidget: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Center(child: CustomTextButton2(text:'Edit',action: (){},)),
      )),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: edgePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(
                      height: width-50,

                      child: Stack(children: [
                        CarouselSlider(
                          items: imgList
                              .map((item) => Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(8.0)),
                                child: Image.asset(
                                  'refAssets/blue_red_image.png',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )),
                          ))
                              .toList(),
                          carouselController: _controller,
                          options: CarouselOptions(
                              autoPlay: true,
                              height: width-40,
                              viewportFraction: 1.0,
                              enlargeCenterPage: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                              imgList.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () => _controller
                                      .animateToPage(entry.key),
                                  child: Container(
                                    width: 12.0,
                                    height: 12.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.BorderDefault.withOpacity(
                                            _current == entry.key
                                                ? 0.9
                                                : 0.4)),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(height: 16),
                    Text('Realme C20 (Cool Grey,32 GB, 2GB RAM)',style: TextStyles.mediumRegular,),
                    SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(rupeesString+' 26999',style: TextStyles.mediumMedium,),
                        SvgPicture.asset('icons/share.svg',height: 24,fit: BoxFit.scaleDown,)
                      ],
                    ),
                    SizedBox(height: 16),

                    Text('Description:',style: TextStyles.smallMedium,),
                    SizedBox(height: 4),

                    Text('2 GB RAM, 16.51 CM, 8 MP Rear Camera, 5000 mAh Battery',style: TextStyles.smallRegularSubdued,),


                    Spacer(),
                    DefaultButton(
                      action: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      text: 'Post Ad',
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
