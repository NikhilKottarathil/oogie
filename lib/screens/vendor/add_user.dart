import 'package:flutter/material.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_app_bars.dart';
import 'package:oogie/components/custom_dropdown.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/screens/vendor/components/attribute.dart';
import 'package:oogie/special_components/image_picker_grid.dart';

class AddUser extends StatefulWidget {
  String title;
  AddUser({this.title});
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  bool switchValue=false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: defaultAppBarWhite(text: widget.title,context: context,),
        body: LayoutBuilder(builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: constraints.maxWidth,
                      minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          CustomTextField2(labelText: 'Name'),
                          CustomTextField2(labelText: 'Shop Name'),
                          CustomTextField2(labelText: 'Mobile Number'),

                          Row(
                            children: [
                              Text('WholeSale Vendor'),
                              Switch(value: switchValue, onChanged: (onChanged){
                              }),
                            ],
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
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: DefaultButton(
                    text: 'SAVE',
                    action: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          );
        })
    );
  }
}
