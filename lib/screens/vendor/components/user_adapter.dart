import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oogie/constants/styles.dart';
import 'package:oogie/screens/vendor/add_user.dart';
class UserAdapter extends StatefulWidget {
  @override
  _UserAdapterState createState() => _UserAdapterState();
}

class _UserAdapterState extends State<UserAdapter> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUser(title: "Edit User Details",)));
      },
      child: Container(padding: EdgeInsets.only(left: 24,right: 24,bottom: 16,top: 16),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
            boxShadow: AppShadows.shadowSmall,
            borderRadius: BorderRadius.circular(8),
            color: AppColors.White
        ),
        child:Row(
          children: [
            Container(
              height:44,
              width:44,
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
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Vendor Name',style: TextStyles.smallMedium),
                Text('9876543210',style: TextStyles.smallRegularSubdued),
                Text('Vendor',style: TextStyles.smallRegularSubdued),
              ],
            )),

          ],
        ),
      ),
    );
  }
}
