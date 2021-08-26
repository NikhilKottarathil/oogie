import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/components/custom_app_bars.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/components/default_button.dart';
import 'package:oogie/screens/explore/used_phones/sell_a_phone_step_3.dart';
import 'package:oogie/screens/shopping/checkout_review.dart';
import 'package:oogie/special_components/image_picking.dart';
import 'package:oogie/special_components/stepper_horizontal.dart';
import 'package:permission_handler/permission_handler.dart';

class SellAPhoneStep2 extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SellAPhoneStep2> {
  final List<File> imgList = [];

  int _current = 0;
  final CarouselController _controller = CarouselController();
  var image2AspectRatio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    image2AspectRatio = Platform.isAndroid
        ? [
            CropAspectRatioPreset.square,
          ]
        : [CropAspectRatioPreset.square];
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;


    return Scaffold(
      appBar: defaultAppBarWhite(
        context: context,
        text: 'Upload your photo',
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: edgePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: imgList.length>0,
                            child: Expanded(
                              child: Center(
                                child: SizedBox(
                                  height: width+40,

                                  child: Stack(children: [
                                    CarouselSlider(
                                      items: imgList
                                          .map((item) => Container(
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(8.0)),
                                                    child: Image.file(
                                                      item,
                                                      fit: BoxFit.fitWidth,
                                                      width: double.infinity,
                                                    )),
                                              ))
                                          .toList(),
                                      carouselController: _controller,
                                      options: CarouselOptions(
                                          autoPlay: true,
                                          height: width-40,
                                          viewportFraction: 1.0,
                                          enlargeCenterPage: true,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              _current = index;
                                            });
                                          }),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children:
                                              imgList.asMap().entries.map((entry) {
                                            return GestureDetector(
                                              onTap: () => _controller
                                                  .animateToPage(entry.key),
                                              child: Container(
                                                width: 12.0,
                                                height: 12.0,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8.0, horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: AppColors.BorderDefault.withOpacity(
                                                        _current == entry.key
                                                            ? 0.9
                                                            : 0.4)),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              File image;
                              if (await Permission.storage.isGranted) {
                                if (await Permission.camera.isGranted) {
                                  image = await pickImage(
                                      context: context,
                                      imageFile: image,
                                      aspectRatios: image2AspectRatio);
                                  imgList.add(image);
                                  setState(() {

                                  });
                                } else {
                                  await [Permission.camera].request();
                                }
                              } else {
                                await [Permission.storage, Permission.camera]
                                    .request();
                              }
                            },
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: AppColors.BorderDefault)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: AppColors.TextDefault,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Add mobile Images'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DefaultButton(
                      action: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SellAPhoneStep3()));
                      },
                      text: 'Continue',
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
