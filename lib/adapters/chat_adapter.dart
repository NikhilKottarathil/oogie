import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/common/chating_page.dart';
import 'package:oogie/constants/styles.dart';

class ChatAdapter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatingPage()));
      },
      child: Container(
        padding:EdgeInsets.all(20) ,
        decoration: BoxDecoration(

          color: AppColors.White,
          boxShadow:AppShadows.shadowTiny
        ),
        child: Row(
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
            SizedBox(width: 8,),
            Expanded(child: Text('Sergio Greenfelder',style: TextStyles.smallMedium,)),
            Container(

              padding: EdgeInsets.only(left: 11,top: 6,right: 11,bottom: 6),
              // color: Colors.green,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
               color: AppColors.PrimaryLightest
              ),
              child: Text('2',style: TextStyles.mediumMediumPrimaryLight,),
            ),
          ],
        ),
      ),
    );
  }
}
