import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/adapters/horizontal_product_view.dart';
import 'package:oogie/adapters/review_adapter.dart';
import 'package:oogie/components/app_bar/secondary_app_bar.dart';
import 'package:oogie/components/custom_progress_indicator.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/explore/product/product_bloc.dart';
import 'package:oogie/screens/explore/product/product_details.dart';
import 'package:oogie/screens/explore/product/product_event.dart';
import 'package:oogie/screens/explore/product/product_highlights.dart';
import 'package:oogie/screens/explore/product/product_state.dart';
import 'package:oogie/screens/explore/product/select_varient.dart';

class ProductView extends StatelessWidget {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {},
      child: Scaffold(
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
                    child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        return state.isLoading
                            ? CustomProgressIndicator()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: edgePadding,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: width - 50,
                                          child: state.productModel.medias
                                                  .isNotEmpty
                                              ? Stack(children: [
                                                  CarouselSlider(
                                                    items:
                                                        state
                                                            .productModel.medias
                                                            .map(
                                                                (item) =>
                                                                    Container(
                                                                      child: ClipRRect(
                                                                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                                                          child: Image.network(
                                                                            item,
                                                                            fit:
                                                                                BoxFit.scaleDown,
                                                                            width:
                                                                                double.infinity,
                                                                          )),
                                                                    ))
                                                            .toList(),
                                                    carouselController:
                                                        _controller,
                                                    options: CarouselOptions(
                                                        autoPlay: true,
                                                        height: width - 40,
                                                        viewportFraction: 1.0,
                                                        enlargeCenterPage: true,
                                                        onPageChanged:
                                                            (index, reason) {}),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: InkWell(
                                                      child: state.productModel
                                                              .isInWishList
                                                          ? SvgPicture.asset(
                                                              'icons/favourite_filled.svg',
                                                              height: 42,
                                                              width: 42,
                                                            )
                                                          : SvgPicture.asset(
                                                              'icons/favourite_outlined.svg',
                                                              fit: BoxFit.cover,
                                                              height: 42,
                                                              width: 42,
                                                            ),
                                                      onTap: () {
                                                        context
                                                            .read<ProductBloc>()
                                                            .add(
                                                                LikeAndUnLikeProduct());
                                                      },
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: state
                                                            .productModel.medias
                                                            .asMap()
                                                            .entries
                                                            .map((entry) {
                                                          return GestureDetector(
                                                            onTap: () => _controller
                                                                .animateToPage(
                                                                    entry.key),
                                                            child: Container(
                                                              width: 8.0,
                                                              height: 8.0,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          8.0,
                                                                      horizontal:
                                                                          4.0),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: AppColors
                                                                      .BorderDefault.withOpacity(_current ==
                                                                          entry
                                                                              .key
                                                                      ? 0.9
                                                                      : 0.4)),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ])
                                              : Center(
                                                  child: SvgPicture.asset(
                                                      Urls().productImage)),
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          state.productModel.displayName,
                                          style: TextStyles.largeRegular,
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              rupeesString +
                                                  state.productModel.unitPrice,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: AppColors.SecondaryBase,
                                              size: 20,
                                            ),
                                            Text(
                                              state.productModel.rating,
                                              style: TextStyles.mediumRegular,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              ' (${state.productModel.ratingCount} ratings)',
                                              style: TextStyles
                                                  .smallRegularSubdued,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 16),
                                      ],
                                    ),
                                  ),
                                  dividerDefault,
                                  ProductHighlights(
                                    highlights: state.productModel.highlights,
                                  ),
                                  Padding(
                                    // padding: const EdgeInsets.only(left: 20,right: 20),
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: InkWell(
                                          onTap: () {
                                            if (state
                                                .productModel.isAddedToCart) {
                                              Navigator.pushNamed(
                                                  context, '/cart');
                                            } else {
                                              context.read<ProductBloc>().add(
                                                  AddProductToCart(
                                                      id: state
                                                          .productModel.id));
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(17),
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                            ),
                                            child: Text(
                                              state.productModel.isAddedToCart
                                                  ? 'Go To Cart'
                                                  : 'Add To Cart',
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
                                            Navigator.pushNamed(
                                                context, '/checkout',
                                                arguments: {
                                                  'parenPage': 'cart',
                                                  'productIds': [
                                                    state.productModel.id
                                                  ]
                                                });
                                          },
                                          child: Container(
                                            width: double.maxFinite,
                                            padding: EdgeInsets.all(17),
                                            decoration: BoxDecoration(
                                              color: AppColors.PrimaryBase,
                                              boxShadow: AppShadows.shadowSmall,
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                              builder: (context) =>
                                                  ProductDetails(
                                                    productModel:
                                                        state.productModel,
                                                  )));
                                    },
                                  ),
                                  dividerDefault,
                                  CustomTextButton3(
                                    text: 'Select Variant',
                                    action: () {
                                      selectVariant(
                                          buildContext: context,
                                          productModel: state.productModel);
                                    },
                                  ),
                                  dividerDefault,
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Review (${state.productModel.reviewCount})',
                                          style: TextStyles.smallMedium,
                                        ),
                                        ListView.separated(
                                          itemCount: state.reviewModels.length,
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return ReviewAdapter(
                                              reviewModel:
                                                  state.reviewModels[index],
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return SizedBox(
                                              height: 20,
                                            );
                                          },
                                        ),
                                        // ReviewAdapter(reviewModel: state.reviewModels[1]),
                                        SizedBox(
                                          height: 24,
                                        ),
                                        Center(
                                            child: CustomTextButton2(
                                          textColor: AppColors.TextSubdued,
                                          text: 'See All Reviews',
                                          action: () {
                                            Navigator.pushNamed(
                                                context, '/reviewList',
                                                arguments: {
                                                  'id': state.productModel.id
                                                });
                                          },
                                        ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: AppColors.SurfaceDisabled,
                                    child: HorizontalProductView(
                                      title: 'Featured Phones',
                                      productModels: state.relatedProducts,
                                    ),
                                  ),
                                ],
                              );
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
