import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:online_attendance/pages/calendar.dart';
import 'package:online_attendance/pages/profile.dart';
import 'package:online_attendance/pages/today.dart';

class UserDashboard extends StatefulWidget {
  UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

List pages = [
  Today(),
  Calendar(),
  ProfilePage(),
];

int selectedIndex = 0;

class _UserDashboardState extends State<UserDashboard> {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(box.read("userID")),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: selectedIndex,

          backgroundColor: Colors.transparent,
          // height: 70,
          color: Color(0xff3498db),
          items: [
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              CupertinoIcons.shopping_cart,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              CupertinoIcons.person,
              size: 30,
              color: Colors.white,
            ),
          ],
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ));
  }
}
