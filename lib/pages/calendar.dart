import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:month_year_picker/month_year_picker.dart';

class Calendar extends StatelessWidget {
  Calendar({super.key});

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              "My attendance",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.050,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  DateFormat('MMMM').format(DateTime.now()),
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w800,
                    fontSize: screenWidth * 0.050,
                  ),
                ),
                Text(
                  "Pick a month",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w800,
                    fontSize: screenWidth * 0.050,
                  ),
                ),
              ],
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            //   child: Container(
            //     height: 30,
            //     width: screenWidth,
            //     decoration: BoxDecoration(
            //       color: Colors.grey,
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Expanded(flex: 1, child: Text("In Time")),
            //         Expanded(flex: 1, child: Text("Out Time")),
            //         Expanded(flex: 1, child: Text("Late Count")),
            //       ],
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 550,
              width: screenWidth,
              // color: Colors.grey,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Employee")
                    .doc(box.read("uniqueID"))
                    .collection("Record")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Stack(
                            children: [
                              Container(
                                width: screenWidth,
                                height: 100,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(
                                          0, 2), // horizontal, vertical offset
                                      blurRadius: 4.0, // spread radius
                                      spreadRadius: 0.0, // blur radius
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                height: 35,
                                width: 80,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(
                                          0, 2), // horizontal, vertical offset
                                      blurRadius: 4.0, // spread radius
                                      spreadRadius: 0.0, // blur radius
                                    ),
                                  ],
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  color: Colors.blueGrey,
                                ),
                                child: Center(
                                  child: Text(
                                    snapshot.data!.docs[index]["dayName"],
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 5,
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  decoration: BoxDecoration(),
                                  child: Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    "Late: " +
                                        snapshot.data!.docs[index]["late"],
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 20,
                                right: 20,
                                bottom: 1,
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  height: 60,
                                  width: 120,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "In Time",
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w600,
                                              fontSize: screenWidth * 0.040,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                ["checkIn"],
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w400,
                                              fontSize: screenWidth * 0.040,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Out Time",
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w600,
                                              fontSize: screenWidth * 0.040,
                                            ),
                                          ),
                                          Text(
                                            snapshot.data!.docs[index]
                                                ["checkout"],
                                            style: GoogleFonts.lato(
                                              fontWeight: FontWeight.w400,
                                              fontSize: screenWidth * 0.040,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                        // return Padding(
                        //   padding:
                        //       EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       color: index % 2 == 0
                        //           ? Colors.white24
                        //           : Colors.grey.shade200,
                        //       border: Border.all(width: 1, color: Colors.black),
                        //     ),
                        //     child: Padding(
                        //       padding: EdgeInsets.all(5.0),
                        //       child: Row(
                        //         children: [
                        //           Expanded(
                        //               flex: 1,
                        //               child: Text(snapshot.data!.docs[index]
                        //                   ["checkIn"])),
                        //           Expanded(
                        //               flex: 1,
                        //               child: Text(snapshot.data!.docs[index]
                        //                   ["checkout"])),
                        //           Expanded(
                        //               flex: 1,
                        //               child: Text(
                        //                   snapshot.data!.docs[index]["late"])),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
