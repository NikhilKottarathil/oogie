import 'package:flutter/material.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/screens/vendor/reports/product_report.dart';
import 'package:oogie/screens/vendor/reports/sale_report.dart';
class Reports extends StatefulWidget {
  @override
  _ReportsState createState() => _ReportsState();
}
class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 2,
            shadowColor: AppColors.SkyLightest.withOpacity(.5),

            title: TabBar(
              unselectedLabelColor: AppColors.TextSubdued,
              labelColor:AppColors.TextDefault ,
              labelStyle: AppStyles.smallRegular,

              indicatorColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.values[1],
              tabs: [
                Tab(
                  icon: Text(
                    "Sale",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Tab(
                    icon: Text(
                      "Product",
                      style:
                      TextStyle( fontSize: 18),
                    )),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              SaleReport(),
              ProductReport(),
            ],
          ),
        ),
      ),
    );
  }
}
