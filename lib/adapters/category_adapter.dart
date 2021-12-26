import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/category_model.dart';

class CategoryAdapter extends StatelessWidget {
  CategoryModel categoryModel;

  CategoryAdapter({this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8, top: 8, bottom: 8),
      height: 92,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: CircleAvatar(
              radius: 22,
              backgroundColor: AppColors.White,
              child: categoryModel.imageUrl != null
                  ? Image.network(categoryModel.imageUrl)
                  : SvgPicture.asset(Urls().categoryImage),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            categoryModel.name,
            style: TextStyles.tinyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
