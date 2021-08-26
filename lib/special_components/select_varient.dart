import 'package:flutter/material.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/radio_buttons.dart';

selectVariant({BuildContext buildContext}) async {
  List<RadioModel> storages = [
    RadioModel(true, '128 GB'),
    RadioModel(false, '64 GB'),
    RadioModel(false, '32 GB'),
  ];

  List<RadioModel> rams = [
    RadioModel(true, '8 GB'),
    RadioModel(false, '6 GB'),
    RadioModel(false, '4 GB'),
  ];
  await showModalBottomSheet(
      context: buildContext,
      enableDrag: false,

      useRootNavigator: true,
      isScrollControlled: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (builder) {
        double height = MediaQuery.of(buildContext).size.height;

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState
                /*You can rename this!*/) {
              return Container(
                height: height * .6,
                margin: EdgeInsets.only(top: 25),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Wrap(

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
                                      'Select Variant',
                                      style: AppStyles.largeRegular,
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
                                SizedBox(height: 8,),
                                Text(
                                  'Realme C20 (120 GB Storage)',
                                  style: AppStyles.mediumRegular,
                                ),
                              ],
                            ),
                          ),
                          dividerDefault,
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  'Storage',
                                  style: AppStyles.smallMedium,
                                ),
                                SizedBox(
                                  height: 60,
                                  child: ListView.builder(
                                      padding: EdgeInsets.only(right: 12,top: 12,bottom: 12),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: storages.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkWell(
                                          child: RadioItem(storages[index]),
                                          onTap: () {
                                            storages
                                                .forEach((element) => element.isSelected = false);
                                            storages[index].isSelected = true;

                                            setState(() {});
                                          },
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),

                          dividerDefault,
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(
                                  'RAM',
                                  style: AppStyles.smallMedium,
                                ),
                                SizedBox(
                                  height: 60,
                                  child: ListView.builder(
                                      padding: EdgeInsets.only(right: 12,top: 12,bottom: 12),
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: rams.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return InkWell(
                                          child: RadioItem(rams[index]),
                                          onTap: () {
                                            rams
                                                .forEach((element) => element.isSelected = false);
                                            rams[index].isSelected = true;

                                            setState(() {});
                                          },
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(height: 100,)

                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: DefaultButton(text: 'Apply',action: (){
                          Navigator.of(context).pop();

                        },),
                      ),
                    )
                  ],
                ),
              );

            });
      });

}
