import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

typedef void StringCallback(String val);

class CustomDropdown extends StatefulWidget {
  var selected;
  final items;
  final titleText;
  final StringCallback callback;

  CustomDropdown({
    Key key,
    this.selected,
    this.titleText,
    this.callback,
    this.items,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.titleText == null || widget.titleText == ''
                ? false
                : true,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: new Text(
                widget.titleText == null ? '' : widget.titleText,
                style: TextStyles.smallRegular,
              ),
            ),
          ),
          Container(
              // padding: EdgeInsets.all(12),
              decoration: new BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.grey.shade300,
                //       blurRadius: 3.0,
                //       offset: Offset(0.0, 0.75)),
                // ],
                border: Border.all(color: AppColors.BorderDefault),
                color: Colors.white,
                borderRadius: new BorderRadius.all(const Radius.circular(4.0)),
              ),
              child: DropdownButton<String>(
                value: widget.selected,
                iconSize: 24,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: AppColors.TextDefault,
                ),
                elevation: 16,
                style: TextStyle(color: Colors.grey),
                underline: Container(
                  height: 2,
                  color: Colors.transparent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    widget.selected = newValue;
                    widget.callback(newValue);
                  });
                },
                items:
                    widget.items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text('\t $value',
                        textAlign: TextAlign.center,
                        style: TextStyles.smallRegularSubdued),
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }
}
