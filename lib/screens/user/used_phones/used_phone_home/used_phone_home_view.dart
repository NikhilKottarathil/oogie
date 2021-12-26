import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/default_appbar_blue.dart';
import 'package:oogie/components/app_bar/main_appbar.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/models/user_model.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/screens/common/order/delivery_orders/delivery_orders_bloc.dart';
import 'package:oogie/screens/common/order/delivery_orders/delivery_orders_view.dart';

import 'package:oogie/screens/user/used_phones/used_phone_home/used_phone_home_bloc.dart';
import 'package:oogie/screens/user/used_phones/used_phone_home/used_phone_home_events.dart';
import 'package:oogie/screens/user/used_phones/used_phone_home/used_phone_home_state.dart';
import 'package:oogie/screens/vendor/product_list_by_creator/product_list_by_creator_bloc.dart';
import 'package:oogie/screens/vendor/product_list_by_creator/product_list_by_creator_view.dart';
class UsedPhoneHomeView extends StatefulWidget {
  @override
  _UsedPhoneHomeViewState createState() => _UsedPhoneHomeViewState();
}

class _UsedPhoneHomeViewState extends State<UsedPhoneHomeView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Widget> _tabList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabList=[BlocProvider(
        child: ProductListByCreatorView(),
        create: (context) => ProductListByCreatorBloc(
            productRepository: productRepository, parentPage: 'usedProductsHome')),
      BlocProvider(
        create: (context) => DeliveryOrdersBloc(
          parentPage: 'usedProductOrders',
            orderRepository: orderRepository),
        child: DeliveryOrdersView(),
      ),


    ];
    _tabController = TabController(length: _tabList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Color fabColor = AppColors.PrimaryBase;

    return Scaffold(
      appBar: defaultAppBarBlue(context: context,text: 'Used Phones',),
      body: BlocBuilder<UsedPhoneHomeBloc, UsedPhoneHomeState>(
        builder: (context, state) {
          _tabController.animateTo(state.tabIndex);
          return TabBarView(
            physics: NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: _tabList,
          );
        },
      ),


      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        clipBehavior: Clip.antiAlias,
        child: BlocBuilder<UsedPhoneHomeBloc, UsedPhoneHomeState>(
          builder: (context, state) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state.tabIndex,
              onTap: (int index) {
                context.read<UsedPhoneHomeBloc>().add(ChangeTab(index));
              },
              items: [
                BottomNavigationBarItem(
                  // icon: Image.asset(
                  //   "images/feed_icon_inactive.png",
                  //   height: 22,
                  // ),
                  icon: Icon(
                    Icons.list,
                  ),
                  // activeIcon: Image.asset(
                  //   "images/feed_icon.png",
                  //   height: 24,
                  // ),
                  // size: MediaQuery.of(context).size.height * .035),
                  label: "Products",
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.inbox,
                    ),
                    // activeIcon: Image.asset(
                    //   "images/ic_chat.png",
                    //   height: 24,
                    // ),
                    label: "Orders"),

              ],
            );
          },
        ),
      ),
    );
  }
}
