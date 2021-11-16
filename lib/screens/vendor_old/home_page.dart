import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oogie/screens/vendor_old/invoices.dart';
import 'package:oogie/screens/vendor_old/orders.dart';
import 'package:oogie/screens/vendor_old/products.dart';
import 'package:oogie/screens/vendor_old/reports/reports.dart';
import 'package:oogie/screens/vendor_old/users.dart';

import 'components/vendor_appbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  int _currentIndex = 0;

  List<Widget> _tabList = [
    Reports(),
    Products(),
    Orders(),
    Invoices(),
    Users()
  ];
  List<String> _tabTitleList = [
    'Reports',
    'Products',
    'Orders',
    'Invoice',
    'Users'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _tabList.length, vsync: this);

    _tabController.animateTo(_currentIndex);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: const Color(0xFF144169),
        statusBarIconBrightness: Brightness.light));
    return SafeArea(
      child: Scaffold(
        appBar:
            vendorAppBar(context: context, text: _tabTitleList[_currentIndex]),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: _tabList,
        ),
        // floatingActionButton: FloatingActionButton(
        //   elevation: 10,
        //   hoverColor: AppColors.PrimaryColorLight,
        //   backgroundColor: Colors.blue,
        //   onPressed: () {
        //     fabColor = Colors.white;
        //     setState(() {
        //       print("success");
        //     });
        //
        //     showDialog(context);
        //
        //   },
        //   child: Container(
        //     height: MediaQuery.of(context).size.height * .085,
        //     width: MediaQuery.of(context).size.height * .085,
        //     decoration: BoxDecoration(shape: BoxShape.circle, color: fabColor),
        //     child: Icon(Icons.add, size: 40),
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 6,
          clipBehavior: Clip.antiAlias,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
              print("Index $_currentIndex");
              _tabController.animateTo(_currentIndex);
            },
            items: [
              // BottomNavigationBarItem(
              //   icon:Image.asset("images/feed_icon_inactive.png",scale:1.6,),
              //   activeIcon:Image.asset("images/feed_icon.png",scale:1.4,) ,
              //   // size: MediaQuery.of(context).size.height * .035),
              //   label: "Reports",
              // ),
              // BottomNavigationBarItem(
              //
              //     icon:Image.asset("images/ic_chat_inactive.png",scale:1.6,),
              //     //
              //     activeIcon:Image.asset("images/ic_chat.png",scale:1.4) ,
              //     label: "Products"),
              // BottomNavigationBarItem(
              //     icon:Image.asset("images/ic_chat_inactive.png",scale:1.6,),
              //     //
              //     activeIcon:Image.asset("images/ic_chat.png",scale:1.4) ,
              //     label: "Orders"),
              // BottomNavigationBarItem(
              //     icon:Image.asset("images/ic_chat_inactive.png",scale:1.6,),
              //     //
              //     activeIcon:Image.asset("images/ic_chat.png",scale:1.4) ,
              //     label: "Invoices"),
              // BottomNavigationBarItem(
              //     icon:Image.asset("images/ic_chat_inactive.png",scale:1.6,),
              //     //
              //     activeIcon:Image.asset("images/ic_chat.png",scale:1.4) ,
              //     label: "Users"),
              BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart),
                activeIcon: Icon(Icons.insert_chart),

                // size: MediaQuery.of(context).size.height * .035),
                label: "Reports",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  activeIcon: Icon(Icons.list),
                  label: "Products"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.library_books),
                  activeIcon: Icon(Icons.library_books),
                  label: "Orders"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_rounded),
                  activeIcon: Icon(Icons.dashboard_rounded),
                  label: "Invoices"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  activeIcon: Icon(Icons.people),
                  label: "Users"),
            ],
          ),
        ),
      ),
    );
  }
}
