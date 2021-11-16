import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/address_model.dart';

class AddressAdapter extends StatefulWidget {
  String parentPage;
  AddressModel addressModel;
  Function optionAction, makeAsDefaultAction, editAction;

  AddressAdapter(
      {Key key,
      this.parentPage,
      this.addressModel,
      this.makeAsDefaultAction,
      this.editAction,
      this.optionAction})
      : super(key: key);

  @override
  _AddressAdapterState createState() => _AddressAdapterState();
}

class _AddressAdapterState extends State<AddressAdapter> {
  @override
  Widget build(BuildContext context) {
    int groupValue = 0;

    AddressModel addressModel;

    addressModel = widget.addressModel;
    if (addressModel.isDefault) {
      groupValue = 1;
    } else {
      groupValue = 0;
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.parentPage == 'checkout'
            ? Container()
            : Radio(
                value: 1,
                groupValue: groupValue,
                onChanged: (int value) async {
                  widget.makeAsDefaultAction();

                  setState(() {
                    groupValue = 1;
                  });
                },
              ),
        Expanded(
          child: InkWell(
            onTap: () {
              widget.editAction();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  addressModel.name,
                  style: TextStyles.smallMedium,
                ),
                Text(
                  addressModel.address1,
                  style: TextStyles.smallRegular,
                ),
                Text(
                  addressModel.address2,
                  style: TextStyles.smallRegular,
                ),
                Text(
                  addressModel.landmark,
                  style: TextStyles.smallRegular,
                ),
                Row(
                  children: [
                    Text(
                      addressModel.city,
                      style: TextStyles.smallRegular,
                    ),
                    Text(
                      addressModel.pinCode,
                      style: TextStyles.smallRegular,
                    ),
                  ],
                ),
                Text(
                  addressModel.state,
                  style: TextStyles.smallRegular,
                ),
                Text(
                  addressModel.phoneNumber,
                  style: TextStyles.smallRegular,
                ),
              ],
            ),
          ),
        ),
        widget.parentPage != 'checkout'
            ? IconButton(
                iconSize: 24,
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(),
                icon: SvgPicture.asset('icons/delete.svg',
                    color: AppColors.TextSubdued),
                onPressed: () {
                  widget.optionAction();
                })
            : Container(),
      ],
    );
  }
}
