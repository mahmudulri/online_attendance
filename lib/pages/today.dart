import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';

import 'package:slide_to_act/slide_to_act.dart';
import 'package:intl/intl.dart';

class Today extends StatefulWidget {
  Today({super.key});

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  final box = GetStorage();
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
        top: 50,
        left: 20,
        right: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: screenWidth / 20,
            ),
          ),
          Text(
            box.read(
              "userID",
            ),
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w500,
              fontSize: screenWidth / 20,
            ),
          ),
          Text(
            "Today's Status",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: screenWidth / 20,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15, bottom: 25),
            height: 150,
            width: screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(2, 2),
                    blurRadius: 10,
                  ),
                ]),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Check in",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth / 18,
                        ),
                      ),
                      Text(
                        "9.00 AM",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth / 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Check Out",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth / 18,
                        ),
                      ),
                      Text(
                        "9.00 AM",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth / 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${DateFormat.d().format(now)}-${DateFormat.MMMM().format(now)}-${DateFormat.y().format(now)}",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: screenWidth / 20,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          StreamBuilder(
            stream: Stream.periodic(Duration(seconds: 1)),
            builder: (context, snapshot) {
              return Text(
                DateFormat('hh:mm:ss a').format(DateTime.now()),
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  fontSize: screenWidth / 20,
                ),
              );
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Builder(
              builder: (context) {
                final GlobalKey<SlideActionState> key = GlobalKey();

                return SlideAction(
                  outerColor: Colors.red,
                  innerColor: Colors.green,
                  sliderRotate: false,
                  onSubmit: () async {
                    print(DateFormat('hh:mm').format(DateTime.now()));

                    QuerySnapshot snapshot = await FirebaseFirestore.instance
                        .collection("Employee")
                        .where("userID", isEqualTo: box.read("userID"))
                        .get();

                    print(snapshot.docs[0].id);
                    // key.currentState!.reset();

                    await FirebaseFirestore.instance
                        .collection("Employee")
                        .doc(snapshot.docs[0].id)
                        .collection("Record")
                        .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
                        .set({
                      "checkIn": DateFormat('hh:mm').format(DateTime.now()),
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    ));
  }

  Future reset() async {}
}
