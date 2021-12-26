import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/special_components/image_picking.dart';

class ImagePickerGrid extends StatelessWidget {
  List<File> imageFiles = [];
  var action;

  ImagePickerGrid({this.imageFiles,this.action});


  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Wrap(
          children: List.generate(imageFiles.length, (index) {
            return InkWell(
              onTap: () async {
                action(index);
              },
              child: Container(
                height: 100,
                  width: 100,
                margin: EdgeInsets.only(right: 6),
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
          }),
        ),
        InkWell(
          onTap: (){
            action(-1);
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                border: Border.all(color: AppColors.BorderDefault),
                borderRadius: BorderRadius.circular(8)),
            child: Center(
                child: SvgPicture.asset(
              'icons/aperture.svg',
              height: 28,
              width: 28,
              fit: BoxFit.cover,
            )),
          ),
        ),
      ],
    );
  }
}
