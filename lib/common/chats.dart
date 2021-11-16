import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oogie/adapters/chat_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/radio_buttons.dart';
import 'package:oogie/constants/styles.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  List<RadioModel> radioModels = [
    RadioModel(true, 'All'),
    RadioModel(false, 'Review'),
    RadioModel(false, 'Seller'),
  ];
  String orderType = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Chat'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 12),
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
          dividerDefault,
          ListView(
            padding: EdgeInsets.all(20),
            shrinkWrap: true,
            children: [
              ChatAdapter(),
              ChatAdapter(),
              ChatAdapter(),
            ],
          )
        ],
      ),
    );
  }
}
