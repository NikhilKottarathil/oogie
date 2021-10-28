import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

class CustomTextButton extends StatefulWidget {
  String text, errorText;
  Function action;
  bool active = true;
  Color textColor;

  CustomTextButton({Key key, this.text, this.errorText, this.action, this.active,this.textColor})
      : super(key: key);

  @override
  _CustomTextButtonState createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
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
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(bottom: 16)),

        InkWell(
          onTap: () {
            widget.action();
          },
          child: Container(
            padding: EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                  color:widget.textColor==null? AppColors.PrimaryBase:widget.textColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'DMSans',
                  fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}


class CustomTextButton2 extends StatefulWidget {
  String text, errorText;
  Function action;
  bool active = true;
  Color textColor;

  CustomTextButton2({Key key, this.text, this.errorText, this.action, this.active,this.textColor})
      : super(key: key);

  @override
  _CustomTextButton2State createState() => _CustomTextButton2State();
}

class _CustomTextButton2State extends State<CustomTextButton2> {
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
      child: Text(
        widget.text,
        style: TextStyle(
            color:widget.textColor==null? AppColors.PrimaryLight:widget.textColor,
            fontWeight: FontWeight.w500,
            fontFamily: 'DMSans',
            fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}


