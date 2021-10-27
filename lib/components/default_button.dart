import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

class DefaultButton extends StatefulWidget {
  String text, errorText;
  Function action;
  bool active = true;

  DefaultButton({Key key, this.text, this.errorText, this.action, this.active})
      : super(key: key);

  @override
  _DefaultButtonState createState() => _DefaultButtonState();
}

class _DefaultButtonState extends State<DefaultButton> {
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
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(padding: EdgeInsets.only(bottom: 16)),

        widget.errorText != null
            ? Padding(
                padding: EdgeInsets.only(bottom: 16, top: 16),
                child: Text(
                  widget.errorText,
                  style: TextStyle(color: Colors.red,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'DMSans',
                      fontSize: 14),

                  textAlign: TextAlign.center,
                ),
              )
            : Padding(
                padding: EdgeInsets.only(top: 16),
              ),
        InkWell(
          onTap: () {
            widget.action();
          },
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(17),
            decoration: BoxDecoration(
              color: widget.active == true
                  ? AppColors.PrimaryBase
                  : AppColors.TextDefault,
              boxShadow: AppShadows.shadowSmall,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                  color: AppColors.SkyLightest,
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
