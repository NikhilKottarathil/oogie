import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';

class CustomImageButton extends StatefulWidget {
  String errorText;
  Function action;
  bool active = true;
  var image;

  CustomImageButton({Key key, this.image, this.errorText, this.action, this.active})
      : super(key: key);

  @override
  _CustomImageButtonState createState() => _CustomImageButtonState();
}

class _CustomImageButtonState extends State<CustomImageButton> {
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
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: AppColors.White,
          boxShadow: AppShadows.shadowSmall,
          borderRadius: BorderRadius.circular(8),

        ),
        child: SvgPicture.asset(widget.image,height: 24,fit: BoxFit.scaleDown,),
      ),
    );
  }
}
