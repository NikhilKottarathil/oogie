import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:oogie/components/custom_video_player.dart';
import 'package:oogie/constants/styles.dart';
import 'package:path/path.dart' as path;

class MultiFileViewer extends StatefulWidget {
  List<File> media;

  MultiFileViewer({Key key, this.media}) : super(key: key);

  @override
  _MultiFileViewerState createState() => _MultiFileViewerState();
}

class _MultiFileViewerState extends State<MultiFileViewer> {
  List<File> media;
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    media = widget.media;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Column(children: [
      CarouselSlider(
        items: media
            .map((item) => Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      child: getFileType(item.path) == 'image'
                          ? Image.file(
                              item,
                              fit: BoxFit.scaleDown,
                              width: double.infinity,
                            )
                          // : getFileType(item.path) == 'video' ||
                          //         getFileType(item.path) == 'audio'
                          //     ? CustomVideoPlayer(
                          //         file: item,
                          //       )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.picture_as_pdf,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(path.basename(item.path))
                              ],
                            )),
                ))
            .toList(),
        carouselController: _controller,
        options: CarouselOptions(
            autoPlay: true,
            height: width - 40,
            viewportFraction: 1.0,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {}),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: media.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 8.0,
                  height: 8.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.BorderDefault.withOpacity(
                          _current == entry.key ? 1 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ]);
  }
}

getFileType(String path) {
  final mimeType = lookupMimeType(path);

  if (mimeType.startsWith('image/')) {
    return 'image';
  } else if (mimeType.startsWith('video/')) {
    return 'video';
  } else if (mimeType.startsWith('audio/')) {
    return 'audio';
  } else if (mimeType.startsWith('application/pdf')) {
    return 'pdf';
  }
}
