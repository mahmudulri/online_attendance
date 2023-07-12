import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:online_attendance/userdashboard.dart';

import 'checkip/ipcontroller.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  final box = GetStorage();

  TextEditingController userIdController = TextEditingController();
  TextEditingController passController = TextEditingController();

  final MyipController myipController = Get.put(MyipController());

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: screenWidth,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: userIdController,
                    decoration: InputDecoration(
                      hintText: "Enter USER ID",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 60,
                width: screenWidth,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    controller: passController,
                    decoration: InputDecoration(
                      hintText: "Enter USER PASS",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  // String userID = userIdController.text.trim();
                  // String passWord = passController.text.trim();
                  String userID = "hasan22";
                  String passWord = "abc123";

                  QuerySnapshot snapshot = await FirebaseFirestore.instance
                      .collection("Employee")
                      .where("userID", isEqualTo: userID)
                      .get();

                  // print(snapshot.docs[0]["passWord"]);

                  if (passWord == snapshot.docs[0]["passWord"]) {
                    print("Successfully logged");
                    box.write("userID", snapshot.docs[0]["userID"]);
                    print(box.read("userID"));
                    Get.to(() => UserDashboard());
                  } else {
                    print("error");
                  }
                },
                child: Text("Log in to Continue"),
              ),
              Obx(
                () => myipController.isLoading.value == true
                    ? CircularProgressIndicator()
                    : Text(
                        myipController.myipdetails.value.ip.toString(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
