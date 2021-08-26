import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/app/app_colors.dart';
import 'package:oogie/app/text_styles.dart';
import 'package:oogie/screens/explore/explore_page.dart';
class ShopAdapter extends StatefulWidget {
  @override
  _ShopAdapterState createState() => _ShopAdapterState();
}

class _ShopAdapterState extends State<ShopAdapter> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ExplorePage()));
      },
      child: Container(padding: EdgeInsets.only(left: 24,right: 24,bottom: 8,top: 8),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          boxShadow: AppShadows.shadowSmall,
          borderRadius: BorderRadius.circular(8),
          color: AppColors.White
        ),
          child:Row(
            children: [
              Container(
                height:40,
                width:40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,

                  // image: DecorationImage(
                  //   fit: BoxFit.cover,
                  //   image: NetworkImage(
                  //       "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9ydHJhaXR8ZW58MHx8MHx8&ixlib=rb-1.2.1&w=1000&q=80"),
                  // ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(child: Text('Shop Name',style: AppStyles.mediumRegular)),
              Icon(Icons.arrow_forward_ios_sharp,color: AppColors.OutlinedIcon,),

            ],
          ),
      ),
    );
  }
}
