import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';
class Attribute extends StatefulWidget {
  String title;
  List values;
  bool isSelected;
  Attribute({this.title,this.isSelected,this.values});
  @override
  _AttributeState createState() => _AttributeState();
}

class _AttributeState extends State<Attribute> {
  bool switchValue=true;
  var radioGroup=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title,style: TextStyles.smallRegular,),
              Switch(value: switchValue, onChanged: (onChanged){
              }),
            ],
          ),
          Visibility(child: SizedBox(
            height: 50,
            child: ListView.builder(
              itemCount: widget.values.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context,int index){
              return Row(
                children: [

                  Radio(value: index, groupValue: radioGroup, onChanged: (value){
                    setState(() {
                      radioGroup=value;
                    });
                  }),
                  Text(widget.values[index],style: TextStyles.smallRegular,),

                ],
              );
            }),
          ))
        ],
      ),
    );
  }
}
