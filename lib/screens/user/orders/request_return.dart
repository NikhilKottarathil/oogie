import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/adapters/order_details_adapter.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/ui_widgets/custom_dropdown.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/special_components/image_picker_grid.dart';

class RequestReturn extends StatefulWidget {
  int step = 1;

  @override
  _RequestReturnState createState() => _RequestReturnState();
}

class _RequestReturnState extends State<RequestReturn> {
  List<String> items = ['Select a reason', 'Wrong Product', 'Damaged', 'Other'];
  String selectedItem = 'Select a reason';

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: defaultAppBarWhite(context: context, text: 'Request Return'),
      body: Container(
        width: width,
        height: height,
        child: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 10),
                          child: Text(
                            'Order ID - 876428347JSBDCKJSDSDYCUI',
                            style: TextStyles.smallRegularSubdued,
                          ),
                        ),
                        dividerDefault,
                        OrderDetailsAdapter(
                            'Canceled',
                            'Redmi 9 (Sky Blue, 4GB RAM, 64GB Storage)',
                            'Ordered on:12/22/2024',
                            'Shop4u',
                            '10030'),
                        dividerDefault,
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              CustomDropdown(
                                titleText: 'Reason for return',
                                items: items,
                                selected: selectedItem,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Capture Product Image',
                                style: TextStyles.smallRegular,
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Note: Any instruction about capturing image goes here',
                                style: TextStyles.tinyRegularSubdued,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              SizedBox(
                                  height: ((width - 40) / 3),
                                  child: ImagePickerGrid()),
                              CustomTextField2(
                                labelText: 'IFSC Code',
                                hintText: 'IFSC000000',
                              ),
                              CustomTextField2(
                                labelText: 'Account Number',
                                hintText: '0000 0000 0000 0000',
                              ),
                              CustomTextField2(
                                labelText: 'Confirm Account Number',
                                hintText: '0000 0000 0000 0000',
                              ),
                              CustomTextField2(
                                  labelText: 'Account Holder Name'),
                              CustomTextField2(labelText: 'Phone Number'),
                            ],
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: DefaultButton(
                    text: 'Submit Request',
                    action: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
