import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/styles.dart';

class CustomTextField extends StatefulWidget {
  final hintText;
  final prefixIcon;
  TextInputType textInputType;
  int maxLines = 1;
  Function suffixAction;
  var suffixType;
  var suffixText;
  bool isLabelEnabled;
  var validator;
  var onChange;
  var text;

  CustomTextField({
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.text,
    this.onChange,
    this.textInputType,
    this.suffixText,
    this.suffixAction,
    this.isLabelEnabled,
    this.suffixType,
    this.maxLines,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isLabelEnabled = true;
  FocusNode _focus = new FocusNode();
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    if (widget.text != null) {
      controller.text = widget.text;
    }
    if (widget.isLabelEnabled != null) {
      isLabelEnabled = widget.isLabelEnabled;
    }
  }

  @override
  void dispose() {
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: " + _focus.hasFocus.toString());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: AppColors.White,
        borderRadius: new BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        focusNode: _focus,
        maxLines: widget.maxLines == null ? 1 : widget.maxLines,
        controller: controller,
        onChanged: widget.onChange,
        validator: widget.validator,
        obscureText: widget.textInputType == TextInputType.visiblePassword
            ? true
            : false,
        enableSuggestions: widget.textInputType == TextInputType.visiblePassword
            ? false
            : true,
        autocorrect: widget.textInputType == TextInputType.visiblePassword
            ? false
            : true,
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'DMSans',
            color: AppColors.TextDefault),
        decoration: new InputDecoration(
          labelText: isLabelEnabled ? widget.hintText : null,
          hintText: isLabelEnabled ? null : widget.hintText,
          contentPadding: const EdgeInsets.all(17.0),
          fillColor: Colors.white,
          alignLabelWithHint: true,
          labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'DMSans',
              color: _focus.hasFocus
                  ? AppColors.TextDefault
                  : AppColors.TextSubdued),
          hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'DMSans',

              color: _focus.hasFocus
                  ? AppColors.TextDefault
                  : AppColors.TextSubdued),
          prefixIcon: widget.prefixIcon != null
              ? SvgPicture.asset(
                  widget.prefixIcon,
                  color: _focus.hasFocus
                      ? AppColors.TextDefault
                      : AppColors.TextSubdued,
                  fit: BoxFit.scaleDown,
                )
              : null,

          suffixIcon: widget.suffixType != null
              ? widget.suffixType == 'optional'
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: Center(
                        child: Text(
                          widget.suffixText,
                          style: TextStyle(
                              fontSize: 12,
                              color: AppColors.Grey1Text,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * .25,
                      child: InkWell(
                        onTap: () {
                          widget.suffixAction();
                        },
                        child: Center(
                          child: Text(
                            widget.suffixText,
                            style: TextStyle(
                              color: AppColors.PrimaryBase,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
              : null,

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.BorderDefault, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),

          enabledBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8.0),
              borderSide:
                  new BorderSide(color: AppColors.BorderDisabled, width: 1.0)),
          errorBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8.0),
              borderSide:
                  new BorderSide(color: AppColors.CriticalBase, width: 1.0)),
          border: AppBorders.transparentBorder,
          disabledBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8.0),
              borderSide:
                  new BorderSide(color: AppColors.BorderDisabled, width: 1.0)),
          focusedErrorBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8.0),
              borderSide:
                  new BorderSide(color: AppColors.CriticalBase, width: 1.0)),
          //fillColor: Colors.green
        ),
        keyboardType: widget.textInputType,
      ),
    );
  }
}
