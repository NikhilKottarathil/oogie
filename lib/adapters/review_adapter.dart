import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
class ReviewAdapter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16,),
        Row(
          children: [
            Container(
              height:40,
              width:40,
              // color: Colors.green,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gregg Graham',style: AppStyles.smallMedium),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColors.SecondaryBase,
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color: AppColors.SecondaryBase,
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color: AppColors.SecondaryBase,
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color: AppColors.SecondaryBase,
                      size: 20,
                    ),
                    Icon(
                      Icons.star_border,
                      color: AppColors.BorderDisabled,
                      size: 20,
                    ),

                  ],
                )
              ],
            )
          ],
        ),
        SizedBox(height: 16,),
        Row(
          children: [
            SvgPicture.asset('icons/review.svg',height: 32,width: 32,fit: BoxFit.cover,),
            SizedBox(
              width: 24,
            ),
            Expanded(child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',style: AppStyles.smallRegular)),
          ],
        ),
      ],
    );
  }
}
