// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/UI/table_reservation.dart';
import '../main.dart';
import './listt.dart';

class TabelPicScreen extends StatefulWidget {
  const TabelPicScreen({super.key, String? userId});

  @override
  State<TabelPicScreen> createState() => _TabelPicScreenState();
}

class _TabelPicScreenState extends State<TabelPicScreen> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String? userId = Provider.of<UserData>(context).userId;
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        backgroundColor: const Color.fromARGB(255, 43, 171, 196),
        title: const Text(
          'Table Booking',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: hight * 0.29,
                    crossAxisSpacing: width * 0.021,
                    crossAxisCount: 2),
                itemCount: tabelList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (count == 0 &&
                          tabelList[index]["_isChecked"] == false) {
                        setState(() {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(
                                tabelList[index]["text"],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                              content: SizedBox(
                                height: hight * .23,
                                width: width * .54,
                                child: Image.asset(tabelList[index]['img']),
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TableRes()));
                                        if (count == 0 &&
                                            tabelList[index]["_isChecked"] ==
                                                false) {
                                          tabelList[index]["_isChecked"] = true;
                                          count = 1;
                                        }
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color: Color(0xFF2babc4),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        width: width * .18,
                                        padding: const EdgeInsets.all(10),
                                        child: const Text(
                                          "Book",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();

                                        if (count == 1 &&
                                            tabelList[index]["_isChecked"] ==
                                                true) {
                                          tabelList[index]["_isChecked"] =
                                              false;
                                          count = 0;
                                        }
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            color:
                                                Color.fromARGB(133, 60, 60, 60),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        padding: const EdgeInsets.all(10),
                                        child: const Text(
                                          "Cancel",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        });
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * .051, vertical: hight * .01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: hight * .27,
                            width: width * .4,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                    width: 3),
                                color: tabelList[index]["color"],
                                borderRadius: BorderRadius.circular(8)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: hight * .2,
                                  width: width * .4,
                                  child: Image.asset(
                                    tabelList[index]['img'],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  height: hight * .01,
                                ),
                                Text(
                                  tabelList[index]["title"],
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: hight * .01,
                                ),
                                Text(
                                  // ignore: prefer_interpolation_to_compose_strings
                                  "Number Of Guests:" +
                                      tabelList[index]["NumGuest"],
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
