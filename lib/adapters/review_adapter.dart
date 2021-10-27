import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/models/review_model.dart';

class ReviewAdapter extends StatelessWidget {
  ReviewModel reviewModel;

  ReviewAdapter({@required this.reviewModel});

  @override
  Widget build(BuildContext context) {
    double rating = double.parse(reviewModel.ratingCount);
    //
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'icons/review.svg',
          height: 32,
          width: 32,
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: 12,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(reviewModel.userName, style: TextStyles.smallMedium),
                  Text(
                    reviewModel.createdTime,
                    softWrap: true,
                    maxLines: 10,
                    style: TextStyles.tinyRegularSubdued
                    ,
                  ),
                ],
              ),
              RatingBarIndicator(
                unratedColor: AppColors.SkyLight,
                itemPadding: EdgeInsets.zero,
                rating: rating,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 14,
                ),
                itemCount: 5,
                itemSize: 14,
                direction: Axis.horizontal,
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                reviewModel.name ,
                softWrap: true,
                maxLines: 10,
                style: TextStyles.smallRegular,
              ),
              SizedBox(height: 5,),

            ],
          ),
        ),
      ],
    );
  }
}
