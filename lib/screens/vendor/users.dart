import 'package:flutter/material.dart';
import 'package:oogie/components/custom_textfield_2.dart';
import 'package:oogie/screens/vendor/add_user.dart';
import 'package:oogie/screens/vendor/components/user_adapter.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 4, bottom: 20),
        child: Column(
          children: [
            CustomTextField2(prefixIcon: 'icons/search.svg',hintText: 'Search',),
            SizedBox(height: 20,),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  UserAdapter(),
                  UserAdapter(),
                  UserAdapter(),

                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddUser(title: 'Add User',)));
        },
        child: Icon(Icons.add),
      ),


    );
  }
}
