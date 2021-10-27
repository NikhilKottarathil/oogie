import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:oogie/components/custom_dropdown.dart';
import 'package:oogie/constants/styles.dart';

class ProductReport extends StatefulWidget {
  @override
  _ProductReportState createState() => _ProductReportState();
}

class _ProductReportState extends State<ProductReport> {
  @override
  Widget build(BuildContext context) {
    List<String> items = [
      'Daily Overview',
      'Weekly Overview',
      'Monthly Overview'
    ];
    String selectedItem = 'Daily Overview';
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Product Sale",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            CustomDropdown(
              items: items,
              selected: selectedItem,
            ),
            SizedBox(height: 20),
            Chart(),
            StorageInfoCard(
              title: "Redmi 9",
              amount: "1800000",
              number: 1328,
            ),
            StorageInfoCard(
              title: "RealMe 9 Pro",
              amount: "15000",
              number: 1228,
            ),
            StorageInfoCard(
              title: "RealMe 9 Pro",
              amount: "15000",
              number: 1228,
            ),
            StorageInfoCard(
              title: "RealMe 9 Pro",
              amount: "15000",
              number: 1228,
            ),
            StorageInfoCard(
              title: "RealMe 9 Pro",
              amount: "15000",
              number: 1228,
            ),
            StorageInfoCard(
              title: "POCO X3",
              amount: "130000",
              number: 1128,
            ),
            StorageInfoCard(
              title: "Unknown",
              amount: "130000",
              number: 140,
            ),
          ],
        ),
      ),
    );
  }
}

class Chart extends StatefulWidget {
  const Chart({
    Key key,
  }) : super(key: key);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Container(
        child: Stack(
          children: [
            PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 70,
                startDegreeOffset: -90,
                sections: paiChartSelectionDatas,
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "29.1",
                    style: Theme.of(context).textTheme.headline4.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          height: 0.5,
                        ),
                  ),
                  // Text("of 128GB")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    color: AppColors.PrimaryBase,
    value: 25,
    // title: 'Remdi 9',
    // titleStyle: TextStyles.tinyRegular,
    showTitle: false,
    radius: 25,
  ),
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 20,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFFFFCF26),
    value: 10,
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 15,
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    color: AppColors.PrimaryBase.withOpacity(0.1),
    value: 25,
    showTitle: false,
    radius: 13,
  ),
];

class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard({
    Key key,
    @required this.title,
    @required this.amount,
    @required this.number,
  }) : super(key: key);

  final String title, amount;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.BorderDefault),
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.smallRegular,
                ),
                Text(
                  "$number items",
                  style: TextStyles.tinyRegularSubdued,
                ),
              ],
            ),
          ),
          Text(
            rupeesString + " " + amount,
            style: TextStyles.smallMedium,
          )
        ],
      ),
    );
  }
}
