import 'package:flutter/material.dart';
import 'package:oogie/components/app_bar/default_appbar_white.dart';

import 'package:oogie/components/custom_dropdown.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/vendor/components/attribute.dart';
import 'package:oogie/special_components/image_picker_grid.dart';

class AddProduct extends StatefulWidget {
  String title;
  AddProduct({this.title});
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String>categories=['Select Category','Phone','Screen Card'];
  String selectedCategory='Select Category';
  List<String>brands=['Select Brand','IPhone','RealMe'];
  String selectedBrand='Select Brand';
  List<String>models=['Select Model','RealMe 9','RealMe 9 Pro'];
  String selectedModel='Select Model';
  List<String>units=['Select Unit','Pk','Bx','Cs'];
  String selectUnit='Select Unit';
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
                          CustomDropdown(items: categories,selected: selectedCategory,),
                          CustomDropdown( items: brands,selected: selectedBrand,),
                          CustomDropdown( items: models,selected: selectedModel,),
                          CustomDropdown(items: units,selected: selectUnit,),
                          Attribute(title: 'Color Attribute',isSelected: true,values: ['Black','White','Grey'],),
                          CustomTextField2(labelText: 'Enter Product Name'),
                          CustomTextField2(labelText: 'Enter Unit Price'),
                          CustomTextField2(labelText: 'Discount Price'),
                          CustomTextField2(labelText: 'Number of Quantity'),
                          CustomTextField2(labelText: 'Model Number',hintText: 'REDMI00000000000',),
                          CustomTextField2(labelText: 'Specification'),
                          CustomTextField2(labelText: 'Highlights'),
                          SizedBox(height: 12,),
                          Text('Capture Product Image',style: TextStyles.smallRegular,),
                          SizedBox(height: 2,),
                          Text('Note: Any instruction about capturing image goes here',style: TextStyles.tinyRegularSubdued,),
                          SizedBox(height: 8,),
                          SizedBox(
                              height: ((width-40)/3),
                              child: ImagePickerGrid()),
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
