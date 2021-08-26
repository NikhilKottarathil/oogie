import 'package:flutter/material.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
class RadioItem extends StatelessWidget {
  final RadioModel _item;

  RadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(right: 10),
      padding: new EdgeInsets.only(left: 16.0, right: 16.0, top: 8, bottom: 8),
      child: Center(
        child: new Text(
          _item.text,
          style: _item.isSelected?AppStyles.smallRegularPrimaryLight:AppStyles.smallRegular),
        ),

      decoration: new BoxDecoration(
        color: AppColors.White,
        border: new Border.all(
            color: _item.isSelected
                ? AppColors.PrimaryLight:AppColors.BorderDefault),
        borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
      ),
    );
  }
}

class RadioItem2 extends StatelessWidget {
  final RadioModel _item;

  RadioItem2(this._item);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.only(right: 10),
      padding: new EdgeInsets.only(left: 16.0, right: 16.0, top: 8, bottom: 8),
      child: Center(
        child: new Text(
            _item.text,
            style: _item.isSelected
                ? AppStyles.smallRegularWhite:AppStyles.smallRegular),
      ),

      decoration: new BoxDecoration(
        color: _item.isSelected
            ? AppColors.PrimaryLight:AppColors.White,
        border: new Border.all(
            color: _item.isSelected
                ? AppColors.PrimaryLight:AppColors.BorderDefault),
        borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String text;

  RadioModel(this.isSelected, this.text);
}
