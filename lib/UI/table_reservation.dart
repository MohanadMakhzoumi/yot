// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import './booking_confirm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'booking_confirm.dart';

class TableRes extends StatefulWidget {
  const TableRes({super.key});

  @override
  State<StatefulWidget> createState() {
    return TableResState();
  }
}

var checker;

class TableResState extends State<TableRes> {
  TimeOfDay time = const TimeOfDay(hour: 00, minute: 00);

  DateTime getNow() {
    DateTime now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
  }

  TextEditingController tablenumController = TextEditingController();
  TextEditingController guestsController = TextEditingController();
  TextEditingController childrennumController = TextEditingController();
  @override
  void dispose() {
    guestsController.dispose();
    childrennumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    GlobalKey<FormState> check = GlobalKey<FormState>();

    void Save() {
      var checkfeild = check.currentState;
      if (checkfeild!.validate() && getNow().hour > 0) {
        checkfeild.save();
        storeReservation(tablenumController.text, guestsController.text,
            childrennumController.text, getNow());

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookingConfirm(userId: userId)));
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFF2babc4),
        title: const Text(
          'Table Reservation',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
      body: Form(
        key: check,
        child: ListView(
          children: <Widget>[
            //Element #1
            const Padding(
              padding: EdgeInsets.only(top: 30.0, left: 15.0, bottom: 15.0),
              child: Text(
                'Arrival Time:',
                style: TextStyle(
                    fontSize: 19.0, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),

            //Element #2
            Center(
              child: Text(
                '${time.hour}:${time.minute}',
                style: const TextStyle(fontSize: 19.0, color: Colors.white),
              ),
            ),

            Container(height: 10.0),

            //Element #3
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: const Color(0xFF2babc4),
                ),
                child: const Text(
                  'Select a time',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: time,
                  );
                  if (newTime == null) return;
                  setState(() {
                    time = newTime;
                  });
                },
              ),
            ),

            //Element #4
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 15.0),
              child: Text(
                'Table Number:',
                style: TextStyle(
                    fontSize: 19.0, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),

            //Element #5
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              child: TextFormField(
                controller: tablenumController,
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Please enter table number";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter your table number...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            //Element #6
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 15.0),
              child: Text(
                'Guests:',
                style: TextStyle(
                    fontSize: 19.0, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),

            //Element #7
            Padding(
              padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              child: TextFormField(
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Please enter guests number";
                  } else {
                    return null;
                  }
                },
                controller: guestsController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter number of guests...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            //Element #8
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 15.0),
              child: Text(
                'Number of children chairs:',
                style: TextStyle(
                    fontSize: 19.0, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),

            //Element #9
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              child: TextField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter number of chairs (optional)...',
                  border: OutlineInputBorder(),
                ),
                controller: childrennumController,
              ),
            ),

            //Element #10
            Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 260.0, right: 30.0, bottom: 50.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    primary: const Color(0xFF2babc4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                child: const Text('Next',
                    style: TextStyle(fontSize: 19.0, color: Colors.black)),
                onPressed: () {
                  Save();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void storeReservation(String TableNum, String GuestsNum, String? ChildrenNum,
    DateTime date) async {
  //FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isValid = false;
  var userId;
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    String userId = currentUser.uid;
    print('User ID: $userId');
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Restaurant')
        .where('Table.tableid', isEqualTo: TableNum)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      isValid = true;
      DocumentReference documentRef = querySnapshot.docs[0].reference;
      Map<String, dynamic> tableStatusData = {
        'Table.tablestatus': {
          'Available': false,
          'Might be available soon': false,
          'Not Available': isValid
        },
      };
      documentRef.update(tableStatusData);
      //checker = true;

      QuerySnapshot querySnapshott =
          await FirebaseFirestore.instance.collection('Restaurant').get();

      if (querySnapshott.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshott = querySnapshott.docs[0];
        Map<String, dynamic>? data =
            documentSnapshott.data() as Map<String, dynamic>?;

        Map<String, dynamic>? tableData =
            data?['Table'] as Map<String, dynamic>?;

        Map<String, dynamic>? tableReservationData =
            tableData?['TableReservation'] as Map<String, dynamic>?;

        dynamic numberOfGuests = tableReservationData?['numberofguests'];

        //if (numberOfGuests == 0) {
        DateTime now = DateTime.now();

        // Combine the user-provided date with the current day
        DateTime combinedDate =
            DateTime(now.year, now.month, now.day, date.hour, date.minute);

        // Format the combined date to your desired format
        String formattedDate =
            DateFormat('yyyy-MM-dd HH:mm').format(combinedDate);

        // DocumentReference documentRef = querySnapshot.docs[0].reference;
        Map<String, dynamic> TableRes = {
          'Table.TableReservation': {
            'userid': userId,
            'reservationid': TableNum,
            'reservationdate': formattedDate,
            'numberofchildrens': ChildrenNum,
            'numberofguests': GuestsNum,
          },
        };
        documentRef.update(TableRes);
      }
    }
  } else {
    print('No user logged in.');
  }

  // Query the 'Table' collection to check if the entered tableNum exists

  // }

  // Get the current date

  // Create a new document in the "TableReservation" collection
  /* await firestore.collection('Restaurant').doc().set({
      'TableReservation': {
        'reservationid': TableNum,
        'reservationdate': formattedDate,
        'tableid': TableNum,
        'numberofchildrens': ChildrenNum,
        'numberofguests': GuestsNum,
      },
      // Other fields you may have
    }).then((value) {
      print('Reservation stored successfully!');
    }).catchError((error) {
      print('Failed to store reservation: $error');
    });
    */
}
  //else {
  //print('this table is reserved');
  /* showDialog(
        context: context,
        builder: (context) {
          return Container(
            margin: const EdgeInsets.only(bottom: 75),
            child: AlertDialog(
              title: const Text(
                'This Table is Reserved!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ),
              content: const Text(
                'Please choose another table.',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ))
              ],
            ),
          );
        });*/
//  }

