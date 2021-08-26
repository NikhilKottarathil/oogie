import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';

class CustomTextField2 extends StatefulWidget {
  final labelText;
  final prefixIcon;
  TextInputType inputType = TextInputType.phone;
  TextEditingController textEditingController;
  bool isValid;
  int maxLines = 1;
  Function suffixAction;
  var suffixType;
  var suffixText;
  var hintText;

  CustomTextField2(
      {this.labelText,
        this.prefixIcon,
        this.inputType,
        this.suffixText,
        this.suffixAction,
        this.suffixType,
        this.maxLines,
        this.hintText,
        this.textEditingController,
        this.isValid});

  @override
  _CustomTextField2State createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  bool isValid = true;
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
    if (widget.isValid != null) {
      isValid = widget.isValid;
    }
    
    return Padding(
      padding: EdgeInsets.only(top: 16),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.labelText!=null,
              child: Text(widget.labelText!=null?widget.labelText:'',style: AppStyles.smallRegular,)),
          Container(
            margin: EdgeInsets.only(top: 3,bottom: 3),
            decoration: BoxDecoration(
              color: AppColors.White,
              borderRadius: new BorderRadius.circular(8.0),
            ),
            child: TextFormField(
              focusNode: _focus,
              maxLines: widget.maxLines == null ? 1 : widget.maxLines,
              controller: widget.textEditingController,
              onChanged: (text) {
                setState(() {
                  isValid = true;
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
                hintText:widget.hintText!=null?widget.hintText:'' ,
                hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'DMSans',
                    color: _focus.hasFocus
                        ? AppColors.TextDefault
                        : AppColors.TextSubdued),
                prefixIcon:widget.prefixIcon!=null? SvgPicture.asset(
                  widget.prefixIcon,
                  color:
                  _focus.hasFocus ? AppColors.TextDefault : AppColors.TextSubdued,
                  fit: BoxFit.scaleDown,
                ):null,


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

                focusedBorder:OutlineInputBorder(
                  borderSide: BorderSide(
                      color:
                      isValid ? AppColors.BorderDefault : AppColors.CriticalBase,
                      width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),

                enabledBorder: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(8.0),
                    borderSide: new BorderSide(
                        color: isValid
                            ? AppColors.BorderDisabled
                            : AppColors.CriticalBase,
                        width: 1.0)),
                //fillColor: Colors.green
              ),
              keyboardType: widget.inputType,
            ),
          ),
        ],
      ),
    );
  }
}
