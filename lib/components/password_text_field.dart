import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oogie/app/app_colors.dart';

class PasswordTextField extends StatefulWidget {
  final hintText;
  final prefixIcon;
  TextEditingController textEditingController;
  bool isValid;
  bool isLabelEnabled;

  PasswordTextField(
      {this.hintText,
      this.prefixIcon,
      this.textEditingController,this.isLabelEnabled,
      this.isValid});

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isValid = true,isLabelEnabled=true,isVisible=true;
  FocusNode _focus = new FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);

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
    if (widget.isLabelEnabled != null) {
      isLabelEnabled = widget.isLabelEnabled;
    }
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.all(const Radius.circular(8.0)),
      ),
      child: TextFormField(
        obscureText: isVisible,
        controller: widget.textEditingController,
        onChanged: (text) {
          setState(() {
            widget.isValid = true;
          });
        },
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            fontFamily: 'DMSans',
            color: AppColors.TextDefault),
        decoration: new InputDecoration(
          contentPadding: const EdgeInsets.all(17.0),
          fillColor: Colors.white,
          labelText: isLabelEnabled?widget.hintText:null,
          hintText:isLabelEnabled?null: widget.hintText,
          labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'DMSans',
              color: _focus.hasFocus
                  ? AppColors.TextDefault
                  : AppColors.TextSubdued) ,
          hintStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'DMSans',
              color: _focus.hasFocus
                  ? AppColors.TextDefault
                  : AppColors.TextSubdued),
          prefixIcon: SvgPicture.asset(
            widget.prefixIcon,
            color:
                _focus.hasFocus ? AppColors.TextDefault : AppColors.TextSubdued,
            fit: BoxFit.scaleDown,
          ),
          suffixIcon: isVisible
              ? InkWell(
                  child: SvgPicture.asset(
                    'icons/eye_open.svg',
                    color: AppColors.TextDefault,
                    fit: BoxFit.scaleDown,
                  ),
                  onTap: () {
                    setState(() {
                      isVisible = false;
                    });
                  })
              : InkWell(
                  child: SvgPicture.asset(
                    'icons/eye_close.svg',
                    color: AppColors.TextSubdued,
                    fit: BoxFit.scaleDown,
                  ),
                  onTap: () {
                    setState(() {
                      isVisible = true;
                    });
                  }),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: widget.isValid
                    ? AppColors.BorderDefault
                    : AppColors.CriticalBase,
                width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(8.0),
              borderSide: new BorderSide(
                  color: widget.isValid
                      ? AppColors.BorderDisabled
                      : AppColors.CriticalBase,
                  width: 1.0)),
        ),
      ),
    );
  }
}
