import 'package:flutter/material.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_app_bars.dart';
import 'package:oogie/components/custom_text_button.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/components/radio_buttons.dart';

filterAndSort({BuildContext buildContext}) async {
  List<RadioModel> sortItems = [
    RadioModel(true, 'Popularity'),
    RadioModel(false, 'Newest'),
    RadioModel(false, 'Oldest'),
  ];

  List<RadioModel> storages = [
    RadioModel(true, '128 GB'),
    RadioModel(false, '64 GB'),
    RadioModel(false, '24 GB'),
  ];

  List<RadioModel> rams = [
    RadioModel(true, '8 GB'),
    RadioModel(false, '6 GB'),
    RadioModel(false, '4 GB'),
  ];
  List<RadioModel> brands = [
    RadioModel(true, 'Realme'),
    RadioModel(false, 'Poco'),
    RadioModel(false, 'Redmi'),
    RadioModel(false, 'Samsung'),
  ];
  List<RadioModel> processors = [
    RadioModel(true, 'Apple'),
    RadioModel(false, 'Mediatek'),
    RadioModel(false, 'Snapdragon'),
    RadioModel(false, 'Intel'),
  ];
  await showModalBottomSheet(
      context: buildContext,
      enableDrag: true,
      useRootNavigator: true,
      isScrollControlled: true,
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      // ),
      builder: (builder) {

        double height = MediaQuery.of(buildContext).size.height;

        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState
                /*You can rename this!*/) {
          return SizedBox(
            height: height-30,
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    defaultAppBarWhite(
                        context: context,
                        text: 'Filter & Sort',
                        prefixWidget: Icon(
                          Icons.close,
                          color: AppColors.OutlinedIcon,
                        ),
                        prefixAction: () {
                          Navigator.of(context).pop();
                        },
                        suffixWidget: Padding(
                          padding: EdgeInsets.only(
                            right: 20,
                          ),
                          child: Center(
                            child: CustomTextButton2(
                              text: 'Clear All',
                              action: () {
                                sortItems = [
                                  RadioModel(true, 'Popularity'),
                                  RadioModel(false, 'Newest'),
                                  RadioModel(false, 'Oldest'),
                                ];

                                storages = [
                                  RadioModel(true, '128 GB'),
                                  RadioModel(false, '64 GB'),
                                  RadioModel(false, '24 GB'),
                                ];

                                rams = [
                                  RadioModel(true, '8 GB'),
                                  RadioModel(false, '6 GB'),
                                  RadioModel(false, '4 GB'),
                                ];
                                brands = [
                                  RadioModel(true, 'Realme'),
                                  RadioModel(false, 'Poco'),
                                  RadioModel(false, 'Redmi'),
                                  RadioModel(false, 'Samsung'),
                                ];
                                processors = [
                                  RadioModel(true, 'Apple'),
                                  RadioModel(false, 'Mediatek'),
                                  RadioModel(false, 'Snapdragon'),
                                  RadioModel(false, 'Intel'),
                                ];
                                setState((){});
                              },
                            ),
                          ),
                        )),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: constraints.maxWidth,
                          minHeight: constraints.maxHeight-50),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sort By',
                                style: AppStyles.smallMedium,
                              ),
                              SizedBox(
                                height: 60,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(
                                        right: 12, top: 12, bottom: 12),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: sortItems.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        child: RadioItem2(sortItems[index]),
                                        onTap: () {
                                          sortItems.forEach((element) =>
                                              element.isSelected = false);
                                          sortItems[index].isSelected = true;

                                          setState(() {});
                                        },
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                'Price Range',
                                style: AppStyles.smallMedium,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: CustomTextField2(
                                    hintText: 'Min Price',
                                        inputType: TextInputType.number,
                                  )),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Expanded(
                                      child: CustomTextField2(
                                    hintText: 'Max Price',
                                        inputType: TextInputType.number,

                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                'Storage',
                                style: AppStyles.smallMedium,
                              ),
                              SizedBox(
                                height: 60,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(
                                        right: 12, top: 12, bottom: 12),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: storages.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        child: RadioItem(storages[index]),
                                        onTap: () {
                                          storages.forEach((element) =>
                                              element.isSelected = false);
                                          storages[index].isSelected = true;

                                          setState(() {});
                                        },
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                'RAM',
                                style: AppStyles.smallMedium,
                              ),
                              SizedBox(
                                height: 60,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(
                                        right: 12, top: 12, bottom: 12),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: rams.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        child: RadioItem(rams[index]),
                                        onTap: () {
                                          rams.forEach((element) =>
                                              element.isSelected = false);
                                          rams[index].isSelected = true;

                                          setState(() {});
                                        },
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                'Brand',
                                style: AppStyles.smallMedium,
                              ),
                              SizedBox(
                                height: 60,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(
                                        right: 12, top: 12, bottom: 12),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: brands.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        child: RadioItem(brands[index]),
                                        onTap: () {
                                          brands.forEach((element) =>
                                              element.isSelected = false);
                                          brands[index].isSelected = true;

                                          setState(() {});
                                        },
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              Text(
                                'Processor Brand',
                                style: AppStyles.smallMedium,
                              ),
                              SizedBox(
                                height: 60,
                                child: ListView.builder(
                                    padding: EdgeInsets.only(
                                        right: 12, top: 12, bottom: 12),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: processors.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        child: RadioItem(processors[index]),
                                        onTap: () {
                                          processors.forEach((element) =>
                                              element.isSelected = false);
                                          processors[index].isSelected = true;

                                          setState(() {});
                                        },
                                      );
                                    }),
                              ),
                              Spacer(),
                              DefaultButton(
                                text: 'Apply',
                                action: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        });
      });
}
