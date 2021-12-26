import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/main_appbar.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_bloc.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_view.dart';
import 'package:oogie/screens/common/order/delivery_orders/delivery_orders_bloc.dart';
import 'package:oogie/screens/common/order/delivery_orders/delivery_orders_view.dart';
import 'package:oogie/screens/delivery_partner/delivery_partner_home/delivery_partner_home_bloc.dart';
import 'package:oogie/screens/delivery_partner/delivery_partner_home/delivery_partner_home_events.dart';
import 'package:oogie/screens/delivery_partner/delivery_partner_home/delivery_partner_home_state.dart';

import 'package:oogie/screens/explore/menu_drawer.dart';


class DeliveryPartnerHomeView extends StatefulWidget {
  @override
  _DeliveryPartnerHomeViewState createState() => _DeliveryPartnerHomeViewState();
}

class _DeliveryPartnerHomeViewState extends State<DeliveryPartnerHomeView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Widget> _tabList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabList.add(BlocProvider(
        child: DeliveryOrdersView(),
        create: (context)=>DeliveryOrdersBloc(orderRepository: orderRepository,parentPage: 'deliveryPartnerOrders')));
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
        body: BlocBuilder<DeliveryPartnerHomeBloc, DeliveryPartnerHomeState>(
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
      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   notchMargin: 6,
      //   clipBehavior: Clip.antiAlias,
      //   child: BlocBuilder<DeliveryPartnerHomeBloc, DeliveryPartnerHomeState>(
      //     builder: (context, state) {
      //       return BottomNavigationBar(
      //         type: BottomNavigationBarType.fixed,
      //         currentIndex: state.tabIndex,
      //         onTap: (int index) {
      //           context.read<DeliveryPartnerHomeBloc>().add(ChangeTab(index));
      //         },
      //         items: [
      //           BottomNavigationBarItem(
      //             // icon: Image.asset(
      //             //   "images/feed_icon_inactive.png",
      //             //   height: 22,
      //             // ),
      //             icon: Icon(
      //               Icons.event,
      //               size: 0,
      //             ),
      //             // activeIcon: Image.asset(
      //             //   "images/feed_icon.png",
      //             //   height: 24,
      //             // ),
      //             // size: MediaQuery.of(context).size.height * .035),
      //             label: "",
      //           ),
      //           BottomNavigationBarItem(
      //               icon: Icon(
      //                 Icons.event,
      //                 size: 0,
      //               ),
      //               // activeIcon: Image.asset(
      //               //   "images/ic_chat.png",
      //               //   height: 24,
      //               // ),
      //               label: ""),
      //         ],
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
