import 'package:flutter/material.dart';
import 'package:oogie/adapters/category_adapter.dart';
import 'package:oogie/components/custom_app_bars.dart';
import 'package:oogie/screens/explore/menu_drawer.dart';
import 'package:oogie/special_components/image_slider.dart';
import 'package:oogie/views/buy_and_sell_view.dart';
import 'package:oogie/views/featured_phones_view.dart';
import 'package:oogie/views/new_arrivals_view.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:             AppBar(title: mainAppBar(context: context)),
      drawer: MenuDrawer(),

      body: NestedScrollView(

        headerSliverBuilder: (context, value) {
          return [
            mainAppBar(context: context)
          ];
        },
        body: SingleChildScrollView(
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 92,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryAdapter(
                        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRj88JcoxeaXhM2ChTBuLzULTltWOl1iigOw&usqp=CAU',
                        name: 'Phone',
                      ),
                      CategoryAdapter(
                        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRj88JcoxeaXhM2ChTBuLzULTltWOl1iigOw&usqp=CAU',
                        name: 'Phone',
                      ),
                      CategoryAdapter(
                        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRj88JcoxeaXhM2ChTBuLzULTltWOl1iigOw&usqp=CAU',
                        name: 'Phone',
                      ),
                      CategoryAdapter(
                        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRj88JcoxeaXhM2ChTBuLzULTltWOl1iigOw&usqp=CAU',
                        name: 'Phone',
                      ),
                      CategoryAdapter(
                        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRj88JcoxeaXhM2ChTBuLzULTltWOl1iigOw&usqp=CAU',
                        name: 'Phone',
                      ),
                      CategoryAdapter(
                        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRj88JcoxeaXhM2ChTBuLzULTltWOl1iigOw&usqp=CAU',
                        name: 'Phone',
                      ),
                    ],
                  ),
                ),
              ),
              BuyAndSellView(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CarouselWithIndicatorDemo(),
              ),

              NewArrivalsView(),
              FeaturedPhoneView(),
            ],
          ),
        ),
      ),
    );
  }
}
