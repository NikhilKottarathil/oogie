import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/adapters/category_adapter.dart';
import 'package:oogie/adapters/horizontal_product_view.dart';
import 'package:oogie/adapters/vertical_product_view.dart';
import 'package:oogie/components/advertisement_view.dart';
import 'package:oogie/components/app_bar/main_appbar.dart';
import 'package:oogie/screens/explore/explore/explore_bloc.dart';
import 'package:oogie/screens/explore/explore/explore_state.dart';
import 'package:oogie/screens/explore/menu_drawer.dart';
import 'package:oogie/utils/firebase_dynamic_link.dart';
import 'package:oogie/views/buy_and_sell_view.dart';

class ExploreView extends StatefulWidget {
  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExploreBloc, ExploreState>(
      listener: (context, state) {},
      child: Scaffold(
        drawer: Platform.isAndroid ? MenuDrawer() : null,
        endDrawer: Platform.isIOS ? MenuDrawer() : null,
        body: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [mainAppBar(context: context)];
          },
          body: SingleChildScrollView(
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 92,
                    child: BlocBuilder<ExploreBloc, ExploreState>(
                      builder: (context, state) {
                        return ListView.builder(
                            itemCount: state.categoryModels.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/productFilter', arguments: {
                                    'parentPage': 'category',
                                    'categoryId': state.categoryModels[index].id
                                  });
                                },
                                child: CategoryAdapter(
                                  categoryModel: state.categoryModels[index],
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ),
                BlocBuilder<ExploreBloc, ExploreState>(
                    builder: (context, state) {
                  return Visibility(
                    visible: state.advertisementModels.isNotEmpty,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: AdvertisementView(
                          advertisementModels: state.advertisementModels),
                    ),
                  );
                }),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/productFilter',
                          arguments: {
                            'parentPage': 'usedProduct',
                          });
                    },
                    child: BuyAndSellView()),
                BlocBuilder<ExploreBloc, ExploreState>(
                  builder: (context, state) {
                    return VerticalProductView(
                        title: 'New Arrivals',
                        productModels: state.newArrivedProductModels,
                        viewAllAction: () {
                          Navigator.pushNamed(context, '/productFilter',
                              arguments: {
                                'parentPage': 'newlyArrivedProducts',
                              });
                        });
                  },
                ),
                BlocBuilder<ExploreBloc, ExploreState>(
                  builder: (context, state) {
                    return HorizontalProductView(
                      title: 'Featured Phones',
                      productModels: state.featuredProductModels,
                      viewAllAction: () {
                        Navigator.pushNamed(context, '/productFilter',
                            arguments: {
                              'parentPage': 'featuredProducts',
                            });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
