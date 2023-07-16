import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:intl/intl.dart';

class Today extends StatefulWidget {
  Today({super.key});

  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  final officeTime =
      FirebaseFirestore.instance.collection("Starting-time").snapshots();

  final box = GetStorage();
  DateTime now = DateTime.now();

  var isLoading = false.obs;

  String checkIn = "--/--";
  String checkOut = "--/--";

  @override
  void initState() {
    checkStatus();
    myofficeTime();

    super.initState();
  }

  // checkTime() async {
  //   final officeTime = FirebaseFirestore.instance
  //       .collection("Officetime")
  //       .doc("starting-time")
  //       .snapshots();
  //   print(officeTime.toString());
  // }

  checkStatus() async {
    try {
      isLoading(true);
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("Employee")
          .where("userID", isEqualTo: box.read("userID"))
          .get();

      DocumentSnapshot snapshot2 = await FirebaseFirestore.instance
          .collection("Employee")
          .doc(snapshot.docs[0].id)
          .collection("Record")
          .doc(DateFormat('dd MMMM yyyy').format(DateTime.now()))
          .get();

      setState(() {
        checkIn = snapshot2["checkIn"];
        checkOut = snapshot2["checkout"];
      });
    } catch (e) {
      setState(() {
        checkIn = "--/--";
        checkOut = "--/--";
      });
    }
    isLoading(false);
  }

  var maintime;
  var startTime;
  var endTime;

  myofficeTime() {
    FirebaseFirestore.instance
        .collection('Officetime')
        .doc("realtime")
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        // print('Document data: ${documentSnapshot.data()}');
        maintime = documentSnapshot.data();
        startTime = maintime["start"];
        endTime = maintime["end"];
        // print(hasan['start']);
        //Set the relevant data to variables as needed
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(officeTime);

    DateTime dt1 = DateTime.parse(DateTime.now().toString());
    DateTime dt2 = DateTime.parse("2023-07-13 09:00:00");
    Duration diff = dt1.difference(dt2);
    // print(diff.inMinutes);

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          print(DateFormat('EE dd').format(DateTime.now()));
        });
      }),
      body: Obx(
        () => isLoading.value == true
            ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Updating Data"),
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "${DateFormat.d().format(now)}-${DateFormat.MMMM().format(now)}-${DateFormat.y().format(now)}",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth * 0.040,
                              ),
                            ),
                            StreamBuilder(
                              stream: Stream.periodic(Duration(seconds: 1)),
                              builder: (context, snapshot) {
                                return Text(
                                  DateFormat('hh:mm:ss a')
                                      .format(DateTime.now()),
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w900,
                                    fontSize: screenWidth / 20,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Office Start",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth * 0.030,
                              ),
                            ),
                            Text(
                              "${startTime} AM",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth * 0.030,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Office Clossing",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth * 0.030,
                              ),
                            ),
                            Text(
                              "${endTime} PM",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w400,
                                fontSize: screenWidth * 0.030,
                              ),
                            ),
                          ],
                        ),
                      ],
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
                                  checkIn,
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
                                  "Check out",
                                  style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenWidth / 18,
                                  ),
                                ),
                                Text(
                                  checkOut,
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
                    checkIn == "--/--"
                        ? Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Builder(
                              builder: (context) {
                                final GlobalKey<SlideActionState> key =
                                    GlobalKey();

                                return SlideAction(
                                  key: key,
                                  text: "Slide to Check in",
                                  outerColor: Colors.blue,
                                  innerColor: Colors.white,
                                  sliderRotate: false,
                                  onSubmit: () async {
                                    QuerySnapshot snapshot =
                                        await FirebaseFirestore
                                            .instance
                                            .collection("Employee")
                                            .where("userID",
                                                isEqualTo: box.read("userID"))
                                            .get();

                                    await FirebaseFirestore.instance
                                        .collection("Employee")
                                        .doc(snapshot.docs[0].id)
                                        .collection("Record")
                                        .doc(DateFormat('dd MMMM yyyy')
                                            .format(DateTime.now()))
                                        .set({
                                      "checkIn": DateFormat('hh:mm')
                                          .format(DateTime.now()),
                                      "checkout": "--/--",
                                      "dayName": DateFormat('EE dd')
                                          .format(DateTime.now()),
                                      "late": "5.20",
                                    });
                                    checkStatus();
                                  },
                                );
                              },
                            ),
                          )
                        : checkIn != "--/--" && checkOut == "--/--"
                            ? Container(
                                margin: EdgeInsets.only(top: 15),
                                child: Builder(
                                  builder: (context) {
                                    final GlobalKey<SlideActionState> key =
                                        GlobalKey();

                                    return SlideAction(
                                      text: "Slide to Check Out",
                                      outerColor: Colors.blue,
                                      innerColor: Colors.white,
                                      sliderRotate: false,
                                      onSubmit: () async {
                                        // print(DateFormat('hh:mm').format(DateTime.now()));

                                        QuerySnapshot snapshot =
                                            await FirebaseFirestore.instance
                                                .collection("Employee")
                                                .where("userID",
                                                    isEqualTo:
                                                        box.read("userID"))
                                                .get();

                                        await FirebaseFirestore.instance
                                            .collection("Employee")
                                            .doc(snapshot.docs[0].id)
                                            .collection("Record")
                                            .doc(DateFormat('dd MMMM yyyy')
                                                .format(DateTime.now()))
                                            .update({
                                          "checkout": DateFormat('hh:mm')
                                              .format(DateTime.now()),
                                        });
                                        checkStatus();
                                      },
                                    );
                                  },
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.black,
                                        )),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      child: Text("Done Today"),
                                    ),
                                  ),
                                ],
                              ),
                  ],
                ),
              ),
      ),
    );
  }
}
