// ignore_for_file: deprecated_member_use, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/views/screens/rate_screen.dart';

import '../../main.dart';

/*void main() {
  runApp(MaterialApp(title: "sd", home: MyApp()));
}*/

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({super.key, String? userId});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  void answerQ() {
    print('Answer chosen!');
    setState(() {
      _inde += 1;
    });

    print(_inde);
  }

  int _inde = 0;

  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    var questions = ["What is your favorite animal?", "What is your name?"];
    return Scaffold(
      backgroundColor: const Color(0xFF010407),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 43, 171, 196),
        ),
        backgroundColor: const Color.fromARGB(255, 43, 171, 196),
        title: const Text(
          'Your Reservation',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Image.asset(
              'assets/images/image1.jpg',
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Restuarant Name",
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Color.fromARGB(255, 43, 171, 196), fontSize: 25),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Row(children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Number of Guests",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "4",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 15),
                    ),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.0, left: 8),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 4, 0, 4),
                      child: Text(
                        "Arriving Time",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "4:30 PM",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 15),
                    ),
                  ]),
                ),
              ]),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 15.0, left: 15),
              child: Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 11.0),
                  child: Column(children: [
                    Text(
                      "Basket",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Meal_1",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14),
                    ),
                    Text(
                      "Meal_2",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14),
                    ),
                    Text(
                      "Meal_3",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14),
                    ),
                    Text(
                      "Meal_4",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14),
                    ),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 130.0),
                  child: Column(children: [
                    Text(
                      "Price",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "44 JOD",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14),
                    ),
                    Text(
                      "4 JOD",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14),
                    ),
                    Text(
                      "16 JOD",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14),
                    ),
                    Text(
                      "22 JOD",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14),
                    ),
                  ]),
                ),
              ]),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(28.0, 26, 0, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Notes",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Your Notes will be here",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 14)),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(28.0, 13, 0, 15),
              child: Row(children: [
                Text(
                  "Total Price: ",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
                ),
                Text(" 88 JOD",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20)),
              ]),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(28.0, 13, 0, 15),
              child: Row(
                children: [
                  Text("Time Left: ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 1, 166, 178),
                          fontSize: 15)),
                  Text("-00:15:00",
                      style: TextStyle(
                          color: Color.fromARGB(255, 207, 0, 0), fontSize: 15)),
                  SizedBox(
                    width: 50,
                  ),
                  Text("Status:  ",
                      style: TextStyle(
                          color: Color.fromARGB(255, 1, 166, 178),
                          fontSize: 15)),
                  Text("Cancelled",
                      style: TextStyle(
                          color: Color.fromARGB(255, 207, 0, 0), fontSize: 15)),
                ],
              ),
            ),
            Center(
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color(0xFF2babc4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RateScreen(userId: userId)),
                    );
                  },
                  child: const Text(
                    'Rate Now!',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
