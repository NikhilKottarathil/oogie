import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';

class CategoryAdapter extends StatelessWidget {
  String imageUrl,name;
  CategoryAdapter({this.name,this.imageUrl});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 68,
      height: 92,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.BorderDisabled),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              )
            ),
          ),
          SizedBox(height: 5,),
          Text(name,style: AppStyles.tinyMedium,),
        ],
      ),
    );
  }
}
