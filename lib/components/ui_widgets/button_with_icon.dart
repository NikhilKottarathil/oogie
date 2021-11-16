
import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

class CustomButtonWithIcon extends StatefulWidget {
  String text;
  IconData icon;
  Function action;

  CustomButtonWithIcon({Key key, this.icon, this.text, this.action})
      : super(key: key);

  @override
  _CustomButtonWithIconState createState() => _CustomButtonWithIconState();
}

class _CustomButtonWithIconState extends State<CustomButtonWithIcon> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.action,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .06,
        decoration:
        BoxDecoration(boxShadow: [BoxShadow(color: AppColors.ShadowColor)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: AppColors.PrimaryLight
            ),
            Text(
              "  " + widget.text,
              style: TextStyle(color: AppColors.PrimaryLight),
            ),
          ],
        ),
      ),
    );
  }
}