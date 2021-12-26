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
import 'package:oogie/special_components/image_slider.dart';
import 'package:oogie/views/buy_and_sell_view.dart';

class ExploreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ExploreBloc, ExploreState>(
      listener: (context, state) {},
      child: Scaffold(
        // appBar:             AppBar(title: mainAppBar(context: context)),
        drawer: MenuDrawer(),

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
                // BuyAndSellView(),
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
                BuyAndSellView(),
                BlocBuilder<ExploreBloc, ExploreState>(
                  builder: (context, state) {
                    return VerticalProductView(
                        title: 'New Arrivals',
                        productModels: state.newArrivedProductModels,
                        viewAllAction: () {
                          Navigator.pushNamed(
                              context, '/productFilter', arguments: {
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
                        Navigator.pushNamed(
                            context, '/productFilter', arguments: {
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
