import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/adapters/review_adapter.dart';
import 'package:oogie/components/app_bar/secondary_app_bar.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/explore/product/product_details.dart';
// import 'package:oogie/screens/shopping/checkout_shipping.dart';
import 'package:oogie/screens/explore/product/select_varient.dart';
import 'package:oogie/views/grid_views/product_landscape_gridview.dart';

class ProductPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<ProductPage> {
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
      appBar: secondaryAppBar(
        context: context,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: edgePadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: width - 50,
                                child: Stack(children: [
                                  CarouselSlider(
                                    items: imgList
                                        .map((item) => Container(
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
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
                                        height: width - 40,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: imgList
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          return GestureDetector(
                                            onTap: () => _controller
                                                .animateToPage(entry.key),
                                            child: Container(
                                              width: 12.0,
                                              height: 12.0,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 8.0,
                                                  horizontal: 4.0),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: AppColors.BorderDefault
                                                      .withOpacity(
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
                              Text(
                                'Realme C20 (Cool Grey,32 GB, 2GB RAM)',
                                style: TextStyles.largeRegular,
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    rupeesString + '26999',
                                    style: TextStyles.largeMedium,
                                  ),
                                  SvgPicture.asset(
                                    'icons/share.svg',
                                    height: 24,
                                    fit: BoxFit.scaleDown,
                                  )
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: AppColors.SecondaryBase,
                                    size: 20,
                                  ),
                                  Text(
                                    '4.6',
                                    style: TextStyles.mediumRegular,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '(54 Reviews)',
                                    style: TextStyles.smallRegularSubdued,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                        dividerDefault,
                        Padding(
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 25, right: 10),
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                  ),
                                  Text(
                                    '2 GB RAM',
                                    style: TextStyles.smallRegular,
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 25, right: 10),
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                  ),
                                  Text(
                                    '16.5 CM',
                                    style: TextStyles.smallRegular,
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 25, right: 10),
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                  ),
                                  Text(
                                    '8 MP Rear Camera',
                                    style: TextStyles.smallRegular,
                                  )
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 25, right: 10),
                                    height: 5,
                                    width: 5,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                  ),
                                  Text(
                                    '5000 mAh Battery',
                                    style: TextStyles.smallRegular,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          // padding: const EdgeInsets.only(left: 20,right: 20),
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, 'cart');
                                },
                                child: Container(
                                  padding: EdgeInsets.all(17),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Text(
                                    'Add To Cart',
                                    style: TextStyle(
                                        color: AppColors.PrimaryBase,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'DMSans',
                                        fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )),
                              Expanded(
                                  child: InkWell(
                                onTap: () {
                                  // Navigator.pushNamed(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             CheckoutShipping()));
                                },
                                child: Container(
                                  width: double.maxFinite,
                                  padding: EdgeInsets.all(17),
                                  decoration: BoxDecoration(
                                    color: AppColors.PrimaryBase,
                                    boxShadow: AppShadows.shadowSmall,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'Buy Now',
                                    style: TextStyle(
                                        color: AppColors.SkyLightest,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'DMSans',
                                        fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                        dividerDefault,
                        CustomTextButton3(
                          text: 'Product Details',
                          action: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetails()));
                          },
                        ),
                        dividerDefault,
                        CustomTextButton3(
                          text: 'Select Variant',
                          action: () {
                            selectVariant(buildContext: context);
                          },
                        ),
                        dividerDefault,
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Review (12)',
                                style: TextStyles.smallMedium,
                              ),
                              ReviewAdapter(),
                              ReviewAdapter(),
                              SizedBox(
                                height: 24,
                              ),
                              Center(
                                  child: CustomTextButton2(
                                textColor: AppColors.TextSubdued,
                                text: 'See All Reviews',
                              ))
                            ],
                          ),
                        ),
                        Container(
                          color: AppColors.SurfaceDisabled,
                          padding: EdgeInsets.all(18),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Featured Phones',
                                    style: TextStyles.displayMedium,
                                  ),
                                ],
                              ),
                              ProductLandscapeGridView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {},
            //   child: Container(
            //     width: double.maxFinite,
            //     padding: EdgeInsets.all(17),
            //     decoration: BoxDecoration(
            //       color: AppColors.PrimaryBase,
            //       boxShadow: AppShadows.shadowSmall,
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //     child: Text(
            //       'Add To Cart',
            //       style: TextStyle(
            //           color: AppColors.SkyLightest,
            //           fontWeight: FontWeight.w500,
            //           fontFamily: 'DMSans',
            //           fontSize: 14),
            //       textAlign: TextAlign.center,
            //     ),
            //   ),
            // )
          ],
        );
      }),
    );
  }
}
