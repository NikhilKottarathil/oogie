import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/special_components/image_picking.dart';

class ImagePickerGrid extends StatefulWidget {
  @override
  _ImagePickerGridState createState() => _ImagePickerGridState();
}

class _ImagePickerGridState extends State<ImagePickerGrid> {
  List<File> imageFiles = [];
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

    File file;
    for (int i = 0; i < 3; i++) {
      imageFiles.add(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 3,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () async {
              imageFiles[index] = await pickImage(
                  context: context,
                  aspectRatios: image2AspectRatio,
                  imageFile: imageFiles[index]);
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                  border: imageFiles[index] == null
                      ? Border.all(color: AppColors.BorderDefault)
                      : null,
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: imageFiles[index] == null
                    ? SvgPicture.asset(
                        'icons/aperture.svg',
                        height: 28,
                        width: 28,
                        fit: BoxFit.cover,
                      )
                    : Image.file(
                        imageFiles[index],
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          );
        });
  }
}
