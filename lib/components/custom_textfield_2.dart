import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/styles.dart';

class CustomTextField2 extends StatefulWidget {
  final labelText;
  final prefixIcon;
  TextInputType textInputType;
  int maxLines = 1;
  Function suffixAction;
  var suffixType;
  var suffixText;
  var hintText;
  var validator;
  var onChange;
  var text;

  CustomTextField2(
      {this.labelText,
        this.prefixIcon,
        this.textInputType,
        this.validator,
        this.text,
        this.onChange,
        this.suffixText,
        this.suffixAction,
        this.suffixType,
        this.maxLines,
        this.hintText,
        });

  @override
  _CustomTextField2State createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  FocusNode _focus = new FocusNode();
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.text != null) {
      controller.text = widget.text;
    }

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

    
    return Padding(
      padding: EdgeInsets.only(top: 16),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.labelText!=null,
              child: Text(widget.labelText!=null?widget.labelText:'',style: TextStyles.smallRegular,)),
          Container(
            margin: EdgeInsets.only(top: 3,bottom: 3),
            decoration: BoxDecoration(
              color: AppColors.White,
              borderRadius: new BorderRadius.circular(8.0),
            ),
            child: TextFormField(
              focusNode: _focus,
              maxLines: widget.maxLines == null ? 1 : widget.maxLines,
              controller: controller,
              onChanged: widget.onChange,
              validator: widget.validator,              obscureText: widget.textInputType == TextInputType.visiblePassword
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

              ),
              keyboardType: widget.textInputType,
            ),
          ),
        ],
      ),
    );
  }
}
