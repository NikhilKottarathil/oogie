import 'package:flutter/material.dart';
import 'package:oogie/adapters/message_adapter.dart';
import 'package:oogie/components/app_bar/chat_appbar.dart';
import 'package:oogie/constants/styles.dart';

class ChatingPage extends StatefulWidget {
  @override
  _ChatingPageState createState() => _ChatingPageState();
}

class _ChatingPageState extends State<ChatingPage> {
  List<MessageGS> messageGSs = new List<MessageGS>();

  @override
  Widget build(BuildContext context) {
    messageGSs.add(new MessageGS(
        "Receive",
        "Lorem ipsum dolor sit amet, consetetur sadipscing elitr",
        "Charu",
        "1h ago"));
    messageGSs.add(new MessageGS(
        "Send", "Lorem ipsum dolor sit amet", "Amal", " 45 min ago"));
    messageGSs.add(new MessageGS(
        "Receive", "Lorem ipsum dolor sit amet", "Cahru", "44 min ago"));
    messageGSs.add(new MessageGS(
        "Send",
        "Lorem ipsum dolor sit amet, consetetur sadipscing elitr",
        "Amal",
        "30 min ago"));
    return Scaffold(
      appBar: chatAppBar(context: context),
      // body: LayoutBuilder(builder: (context, constraints) {
      //   return SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         ConstrainedBox(
      //           constraints: BoxConstraints(
      //               minWidth: constraints.maxWidth,
      //               minHeight: constraints.maxHeight),
      //           child: Container(
      //             height: constraints.maxHeight,
      //             width: constraints.maxWidth,
      //             child: Flexible(
      //               child: ListView.builder(
      //                   shrinkWrap: true,
      //                   reverse: true,
      //                   // physics: NeverScrollableScrollPhysics(),
      //                   itemCount: messageGSs.length,
      //                   itemBuilder: (BuildContext context, int index) {
      //                     return MessageAdapter(messageGSs[index]);
      //                   }),
      //             ),
      //           ),
      //         ),
      //         Padding(
      //           padding: EdgeInsets.all(20),
      //           child: TextField(
      //             decoration: InputDecoration(
      //                 hintText: "Write your message…",
      //                 hintStyle: TextStyles.smallRegularSubdued,
      //                 // prefixIcon: IconButton(
      //                 //   onPressed: () {},
      //                 //   icon: Icon(
      //                 //     Icons.attach_file,
      //                 //     color: AppColors.OutlinedIcon,
      //                 //   ),
      //                 // ),
      //                 border: InputBorder.none,
      //                 suffixIcon: IconButton(
      //                   onPressed: () {},
      //                   icon: Icon(
      //                     Icons.send,
      //                     color: AppColors.TextSubdued,
      //                   ),
      //                 )),
      //           ),
      //         ),
      //
      //       ],
      //     ),
      //   );
      // }),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(20),
                shrinkWrap: true,
                reverse: true,
                // physics: NeverScrollableScrollPhysics(),
                itemCount: messageGSs.length,
                itemBuilder: (BuildContext context, int index) {
                  return MessageAdapter(messageGSs[index]);
                }),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              style: TextStyles.smallRegular,
              decoration: InputDecoration(
                  hintText: "Write your message…",
                  hintStyle: TextStyles.smallRegularSubdued,
                  // prefixIcon: IconButton(
                  //   onPressed: () {},
                  //   icon: Icon(
                  //     Icons.attach_file,
                  //     color: AppColors.OutlinedIcon,
                  //   ),
                  // ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send,
                      color: AppColors.TextSubdued,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
