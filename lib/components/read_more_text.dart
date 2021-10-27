import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';

class ReadMoreText extends StatefulWidget {
  String text;
  int maxLines;

  ReadMoreText({Key ke, this.text, this.maxLines});

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isReadMore = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.text,
          style: TextStyles.smallRegular,
          maxLines: isReadMore ? widget.maxLines : null,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.BackgroundColor,
                shadowColor: AppColors.BackgroundColor,
                primary: AppColors.BackgroundColor,
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                setState(() {
                  isReadMore = !isReadMore;
                });
              },
              child: (Text(
                isReadMore ? 'Read More' : 'Read Less',
                style: TextStyles.smallRegularSubdued,
              ))),
        )
      ],
    );
  }
}
