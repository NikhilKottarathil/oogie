import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oogie/components/app_bar/main_appbar.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/router/app_router.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_bloc.dart';
import 'package:oogie/screens/common/add_connection_agent/add_connection_agent_view.dart';
import 'package:oogie/screens/distributor/connection_agents_list/connection_agents_list_bloc.dart';
import 'package:oogie/screens/distributor/connection_agents_list/connection_agents_list_view.dart';
import 'package:oogie/screens/distributor/distributor_home/distributor_home_bloc.dart';
import 'package:oogie/screens/distributor/distributor_home/distributor_home_events.dart';
import 'package:oogie/screens/distributor/distributor_home/distributor_home_state.dart';
import 'package:oogie/screens/explore/menu_drawer.dart';

class DistributorHomeView extends StatefulWidget {
  @override
  _DistributorHomeViewState createState() => _DistributorHomeViewState();
}

class _DistributorHomeViewState extends State<DistributorHomeView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<Widget> _tabList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabList.add(BlocProvider.value(
        child: ConnectionAgentsListView(),
        value: context.read<ConnectionAgentsListBloc>()));
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
        body: BlocBuilder<DistributorHomeBloc, DistributorHomeState>(
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
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        hoverColor: AppColors.PrimaryLight,
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider(
                        create: (_) => AddConnectionAgentBloc(
                            connectionAgentsListBloc:
                                context.read<ConnectionAgentsListBloc>(),
                            vendorRepository: vendorRepository,
                            wholeSaleRepository: wholeSaleRepository),
                        child: AddConnectionAgentView(),
                      )));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * .085,
          width: MediaQuery.of(context).size.height * .085,
          decoration: BoxDecoration(shape: BoxShape.circle, color: fabColor),
          child: Icon(Icons.add, size: 40),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6,
        clipBehavior: Clip.antiAlias,
        child: BlocBuilder<DistributorHomeBloc, DistributorHomeState>(
          builder: (context, state) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state.tabIndex,
              onTap: (int index) {
                context.read<DistributorHomeBloc>().add(ChangeTab(index));
              },
              items: [
                BottomNavigationBarItem(
                  // icon: Image.asset(
                  //   "images/feed_icon_inactive.png",
                  //   height: 22,
                  // ),
                  icon: Icon(
                    Icons.event,
                    size: 0,
                  ),
                  // activeIcon: Image.asset(
                  //   "images/feed_icon.png",
                  //   height: 24,
                  // ),
                  // size: MediaQuery.of(context).size.height * .035),
                  label: "",
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.event,
                      size: 0,
                    ),
                    // activeIcon: Image.asset(
                    //   "images/ic_chat.png",
                    //   height: 24,
                    // ),
                    label: ""),
              ],
            );
          },
        ),
      ),
    );
  }
}
