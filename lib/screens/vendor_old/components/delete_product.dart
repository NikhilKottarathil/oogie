import 'package:flutter/material.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/constants/styles.dart';

deleteProduct({BuildContext buildContext}) async {
  await showModalBottomSheet(
      context: buildContext,
      enableDrag: true,
      useRootNavigator: true,
      isScrollControlled: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (builder) {
        double height = MediaQuery.of(buildContext).size.height;

        return StatefulBuilder(builder: (BuildContext context,
            StateSetter setState /*You can rename this!*/) {
          return Container(
            margin: EdgeInsets.only(top: 25),
            child: Stack(
              children: [
                Wrap(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delete',
                                style: TextStyles.largeMedium,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  color: AppColors.TextDefault,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            'Are you sure to delete product Realme C20 (120 GB Storage)',
                            style: TextStyles.smallRegular,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: DefaultButton(
                                text: 'Delete',
                                action: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
      });
}
