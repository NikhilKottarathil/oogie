

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showSnackBar(BuildContext context,String message,Function action,String actionText) {
  final snackBar = SnackBar(

    content: Text(
      message, style: TextStyle(color: Colors.black),),
    padding: EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
    margin: EdgeInsets.only(bottom: 25),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.white,
    action: SnackBarAction(
      label: actionText==null?'OK':actionText,
      onPressed: () {
        if(action!=null){
          action();
        }
        // Some code to undo the change.
      },
    ),
  );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}