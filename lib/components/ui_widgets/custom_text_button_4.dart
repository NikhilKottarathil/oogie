import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

class CustomTextButton4 extends StatefulWidget {
  String text, errorText;
  Function action;
  bool active = true;
  Color textColor;

  CustomTextButton4(
      {Key key,
      this.text,
      this.errorText,
      this.action,
      this.active,
      this.textColor})
      : super(key: key);

  @override
  _CustomTextButton4State createState() => _CustomTextButton4State();
}

class _CustomTextButton4State extends State<CustomTextButton4> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.active == null) {
      widget.active = true;
    }
    return InkWell(
      onTap: () {
        widget.action();
      },
      child: Container(
        width: double.maxFinite,
        padding: EdgeInsets.only(top: 17, bottom: 17),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Text(
          widget.text,
          style: TextStyles.smallRegular,
        ),
      ),
    );
  }
}
