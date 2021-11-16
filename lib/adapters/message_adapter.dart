import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

class MessageAdapter extends StatelessWidget {
  MessageGS messageGS;

  MessageAdapter(this.messageGS);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width set up issue pending
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: messageGS.type == "Send"
              ? MediaQuery.of(context).size.width * .25
              : 0,
          right: messageGS.type != "Send"
              ? MediaQuery.of(context).size.width * .25
              : 0),
      width: 100,
      decoration: BoxDecoration(
          color: messageGS.type != "Send"
              ? AppColors.White
              : AppColors.PrimaryBase,
          border: Border.all(color: AppColors.BorderDefault),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                messageGS.message,
                style: messageGS.type != "Send"
                    ? TextStyles.smallRegular
                    : TextStyles.smallRegularWhite,
              )),
          // Align(
          //     alignment: Alignment.bottomRight,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         Text(
          //           messageGS.time,
          //           style: messageGS.type != "Send"?TextStyles.smallRegular:TextStyles.smallRegularWhite,
          //         ),
          //         Icon(Icons.check)
          //       ],
          //     )),
        ],
      ),
    );
  }
}

class MessageGS {
  String message, type, userName, time;

  MessageGS(this.type, this.message, this.userName, this.time);
}
