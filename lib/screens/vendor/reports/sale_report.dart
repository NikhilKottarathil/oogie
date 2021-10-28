import 'package:flutter/material.dart';
import 'package:oogie/components/ui_widgets/custom_dropdown.dart';
import 'package:oogie/screens/vendor/components/line_chart.dart';
class SaleReport extends StatefulWidget {
  @override
  _SaleReportState createState() => _SaleReportState();
}

class _SaleReportState extends State<SaleReport> {
  List<String> items = [
    'Daily Overview',
    'Weekly Overview',
    'Monthly Overview'
  ];
  String selectedItem = 'Daily Overview';
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          CustomDropdown(
            items: items,
            selected: selectedItem,
          ),

          LineChartSample1(),
        ],
      ),
    );
  }
}
