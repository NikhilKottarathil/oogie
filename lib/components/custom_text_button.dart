import 'package:flutter/material.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';

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


class CustomTextButton3 extends StatefulWidget {
  String text, errorText;
  Function action;
  bool active = true;
  Color textColor;

  CustomTextButton3({Key key, this.text, this.errorText, this.action, this.active,this.textColor})
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
              style:AppStyles.smallRegular,
            ),
            Icon(Icons.arrow_forward_ios_sharp,color: AppColors.OutlinedIcon,),
          ],
        ),
      ),
    );
  }
}


class CustomTextButton4 extends StatefulWidget {
  String text, errorText;
  Function action;
  bool active = true;
  Color textColor;

  CustomTextButton4({Key key, this.text, this.errorText, this.action, this.active,this.textColor})
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
        padding: EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Text(
          widget.text,
          style: AppStyles.smallRegular,
        ), ),
    );
  }
}


