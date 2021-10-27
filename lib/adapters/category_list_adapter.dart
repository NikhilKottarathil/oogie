
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/strings_and_urls.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/category_model.dart';

class CategoryListAdapter extends StatelessWidget {
  CategoryModel categoryModel;
  CategoryListAdapter({this.categoryModel});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.White,
          child: categoryModel.imageUrl!=null?Image.network(categoryModel.imageUrl):SvgPicture.asset(Urls().categoryImage),
        ),

        SizedBox(height: 10,),
        Text(categoryModel.name,style: TextStyles.tinyMedium,textAlign: TextAlign.center,),
      ],
    );
  }
}
