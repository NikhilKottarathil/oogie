import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/main_appbar.dart';
import 'package:oogie/constants/app_data.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/flavour_config.dart';
import 'package:oogie/models/user_model.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/screens/common/vendor_sale_report/vendor_sale_report_bloc.dart';
import 'package:oogie/screens/common/vendor_sale_report/vendor_sale_report_view.dart';

import 'package:oogie/screens/explore/menu_drawer.dart';
import 'package:oogie/screens/vendor/order_by_creator/order_by_creator_bloc.dart';
import 'package:oogie/screens/vendor/order_by_creator/order_by_creator_view.dart';
import 'package:oogie/screens/vendor/product_list_by_creator/product_list_by_creator_bloc.dart';
import 'package:oogie/screens/vendor/product_list_by_creator/product_list_by_creator_view.dart';
import 'package:oogie/screens/vendor/vendor_home/vendor_home_bloc.dart';
import 'package:oogie/screens/vendor/vendor_home/vendor_home_events.dart';
import 'package:oogie/screens/vendor/vendor_home/vendor_home_state.dart';

import 'package:oogie/router/app_router.dart';
class VendorHomeView extends StatefulWidget {
  @override
  _VendorHomeViewState createState() => _VendorHomeViewState();
}

class _VendorHomeViewState extends State<VendorHomeView>
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
            productRepository: productRepository, parentPage: 'vendorHome')),
      BlocProvider(
        create: (context) => OrderByCreatorBloc(
            orderRepository: orderRepository),
        child: OrderByCreatorView(),
      ),
       BlocProvider(
              create: (context) => VendorSaleReportBloc(
                  distributorRepository: distributorRepository,
                  parentPage: 'vendorHome',
                 orderRepository: orderRepository,
                  userModel: UserModel(id: AppData().userId,userType: FlavorConfig().flavorValue)),
              child: VendorSaleReportView(),
            ),


    ];
    _tabController = TabController(length: _tabList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Color fabColor = AppColors.PrimaryBase;

    return Scaffold(
      drawer: MenuDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [mainAppBar(context: context)];
        },
        body: BlocBuilder<VendorHomeBloc, VendorHomeState>(
          builder: (context, state) {
            _tabController.animateTo(state.tabIndex);
            return TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: _tabList,
            );
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        clipBehavior: Clip.antiAlias,
        child: BlocBuilder<VendorHomeBloc, VendorHomeState>(
          builder: (context, state) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state.tabIndex,
              onTap: (int index) {
                context.read<VendorHomeBloc>().add(ChangeTab(index));
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
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.event,
                    ),
                    // activeIcon: Image.asset(
                    //   "images/ic_chat.png",
                    //   height: 24,
                    // ),
                    label: "Sales"),
              ],
            );
          },
        ),
      ),
    );
  }
}
