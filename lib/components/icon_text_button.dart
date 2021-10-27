import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/styles.dart';

class IconTextButton extends StatefulWidget {
  String text, iconUrl;
  Function action;

  IconTextButton({Key key, this.iconUrl, this.text, this.action})
      : super(key: key);

  @override
  _IconTextButtonState createState() => _IconTextButtonState();
}

class _IconTextButtonState extends State<IconTextButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.action,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              widget.iconUrl,

              fit: BoxFit.scaleDown,

            ),
            SizedBox(width: 10,),
            Text(
              "  " + widget.text,
              style: TextStyles.mediumMedium,
            ),
          ],
        ),
      ),
    );
  }
}
