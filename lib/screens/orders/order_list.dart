import 'package:flutter/material.dart';
import 'package:oogie/adapters/order_agent_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_blue.dart';
import 'package:oogie/components/radio_buttons.dart';
import 'package:oogie/screens/orders/order_details.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  List<RadioModel> radioModels = [
    RadioModel(true, 'All'),
    RadioModel(false, 'On the way'),
    RadioModel(false, 'Delivered'),
    RadioModel(false, 'Cancelled'),
  ];
  String orderType = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarBlue(context: context, text: 'My Orders'),
      body: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
                padding: EdgeInsets.all(12),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: radioModels.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: RadioItem(radioModels[index]),
                    onTap: () {
                      radioModels
                          .forEach((element) => element.isSelected = false);
                      radioModels[index].isSelected = true;
                      orderType = radioModels[index].text;

                      setState(() {});
                    },
                  );
                }),
          ),
          // ListView(
          //   padding: EdgeInsets.all(20),
          //   shrinkWrap: true,
          //   children: [
          //     orderType == 'All' || orderType == 'On the way'
          //         ? InkWell(
          //             child: OrderAdapter(
          //                 'On the way',
          //                 'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
          //                 'Ordered on:12/22/2024'),
          //             onTap: () {
          //               Navigator.of(context).push(MaterialPageRoute(
          //                   builder: (context) => OrderDetails(1)));
          //             },
          //           )
          //         : Container(),
          //     orderType == 'All' || orderType == 'Delivered'
          //         ? InkWell(
          //             child: OrderAdapter(
          //               'Delivered',
          //               'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
          //               'Ordered on:12/22/2024',
          //             ),
          //             onTap: () {
          //               Navigator.of(context).push(MaterialPageRoute(
          //                   builder: (context) => OrderDetails(3)));
          //             },
          //           )
          //         : Container(),
          //     orderType == 'All' || orderType == 'Cancelled'
          //         ? OrderAdapter(
          //             'Cancelled',
          //             'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
          //             'Ordered on:12/22/2024')
          //         : Container(),
          //   ],
          // )
        ],
      ),
    );
  }
}
