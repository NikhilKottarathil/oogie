import 'package:flutter/material.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

showAlertBottomSheet(
    {BuildContext context,
    String heading,
    content,
    positiveText,
    negativeText,
    neutralText,
    Function positiveAction,
    negativeAction,
    neutralAction}) async {
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
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 35),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: heading!=null,
                    child: Text(
                      heading!=null?heading:'',
                      style: TextStyles.largeRegular,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.close,
                      color: AppColors.SolidIcon,
                    ),
                  )
                ],
              ),
              Visibility(
                visible: content!=null,
                child: Text(
                  content!=null?content:'',
                  style: TextStyles.smallRegular,
                ),
              ),

              Row(

                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  negativeText != null
                      ? InkWell(
                          onTap: () {
                            neutralAction != null
                                ? neutralAction()
                                : Navigator.pop(context);
                          },
                          child: Text(
                              positiveText != null ? positiveText : 'Cancel'))
                      : Container(),
                  Card(


                    child: InkWell(
                        onTap: () {
                          negativeAction != null
                              ? negativeAction()
                              : Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20,10,20,10),
                          child: Text(positiveText != null ? positiveText : 'No',style: TextStyles.mediumRegularCriticalBase),
                        )),
                  ),
                  Card(

                    child: InkWell(
                        onTap: () {
                          positiveAction != null
                              ? positiveAction()
                              : Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20,10,20,10),
                          child: Text(positiveText != null ? positiveText : 'Yes',style: TextStyles.mediumRegularGreenBase,),
                        )),
                  ),
                ],
              )
            ],
          ),
        );
      });
}
