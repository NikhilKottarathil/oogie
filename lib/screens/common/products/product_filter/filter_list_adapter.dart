import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/filter_model.dart';
import 'package:oogie/models/key_value_radio_model.dart';

class FilterListAdapter extends StatefulWidget {
  FilterModel filterModel;
  bool isMultiSelection;

  FilterListAdapter({Key key, this.filterModel, this.isMultiSelection})
      : super(key: key);

  @override
  _FilterListAdapterState createState() => _FilterListAdapterState();
}

class _FilterListAdapterState extends State<FilterListAdapter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.filterModel.name,
          style: TextStyles.smallMedium,
        ),
        SizedBox(height: 14),
        Wrap(
          children: List.generate(
              widget.filterModel.values.length,
              (index) => InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    if (widget.isMultiSelection) {
                      widget.filterModel.values[index].isSelected =
                          !widget.filterModel.values[index].isSelected;
                      setState(() {});
                    } else {
                      widget.filterModel.values.forEach((element) {
                        element.isSelected = false;
                      });
                      widget.filterModel.values[index].isSelected = true;
                      setState(() {});
                    }
                  },
                  child: KeyValueRadioItem(widget.filterModel.values[index]))),
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

class KeyValueRadioItem extends StatelessWidget {
  final KeyValueRadioModel _item;

  KeyValueRadioItem(this._item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, bottom: 10),
      padding: new EdgeInsets.only(left: 16.0, right: 16.0, top: 8, bottom: 8),
      child: new Text(_item.key,
          style: _item.isSelected
              ? TextStyles.smallRegularPrimaryLight
              : TextStyles.smallRegular),
      decoration: new BoxDecoration(
        color: AppColors.White,
        border: new Border.all(
            color: _item.isSelected
                ? AppColors.PrimaryLight
                : AppColors.BorderDefault),
        borderRadius: const BorderRadius.all(const Radius.circular(8.0)),
      ),
    );
  }
}
