// import 'package:flutter/material.dart';
//
// _onShare(BuildContext context) async {
//   // A builder is used to retrieve the context immediately
//   // surrounding the ElevatedButton.
//   //
//   // The context's `findRenderObject` returns the first
//   // RenderObject in its descendent tree when it's not
//   // a RenderObjectWidget. The ElevatedButton's RenderObject
//   // has its position and size after it's built.
//   final RenderBox box = context.findRenderObject() as RenderBox;
//
//   if (imagePaths.isNotEmpty) {
//     await Share.shareFiles(imagePaths,
//         text: text,
//         subject: subject,
//         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//   } else {
//     await Share.share(text,
//         subject: subject,
//         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//   }
// }
//
// _onShareWithEmptyOrigin(BuildContext context) async {
//   await Share.share("text");
// }
// }
