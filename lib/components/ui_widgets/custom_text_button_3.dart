import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

class CustomTextButton3 extends StatefulWidget {
  String text, errorText;
  Function action;
  bool active = true;
  Color textColor;

  CustomTextButton3(
      {Key key,
      this.text,
      this.errorText,
      this.action,
      this.active,
      this.textColor})
      : super(key: key);

  @override
  _CustomTextButton3State createState() => _CustomTextButton3State();
}

class _CustomTextButton3State extends State<CustomTextButton3> {
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
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.text,
              style: TextStyles.smallRegular,
            ),
            Icon(
              Icons.arrow_forward_ios_sharp,
              color: AppColors.OutlinedIcon,
            ),
          ],
        ),
      ),
    );
  }
}
