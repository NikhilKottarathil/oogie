import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

showAlertBottomSheet({
  BuildContext context,
  String heading,
  content,
  positiveText,
  negativeText,
  Function positiveAction,
  Function negativeAction,
}) async {
  await showModalBottomSheet(
      context: context,
      enableDrag: true,
      useRootNavigator: true,
      // isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (builder) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 35),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if(heading != null)
              //   Text(
              //     heading,
              //     style: TextStyles.largeRegular,
              //   ),
              // if(heading != null && content != null)
              //   SizedBox(height: 8,),
              if(content != null)
                Text(
                  content,
                  style: TextStyles.mediumMedium,
                ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          negativeAction != null
                              ? negativeAction()
                              : Navigator.pop(context);
                        },
                        child: Text(
                            negativeText != null ? negativeAction : 'Cancel',
                            style: TextStyles.mediumRegular)),
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          positiveAction != null
                              ? positiveAction()
                              : Navigator.pop(context);
                        },
                        child: Text(
                          positiveText != null ? positiveText : 'Yes',
                          style: TextStyles.mediumRegularWhite,
                        )),
                  ),
                ],
              )
            ],
          ),
        );
      });
}
