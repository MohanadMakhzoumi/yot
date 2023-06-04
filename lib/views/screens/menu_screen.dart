// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/consts/List.dart';
import 'package:restuarant/consts/colors.dart';
import 'package:restuarant/views/screens/menu/sweet_screen.dart';

import '../../main.dart';
import 'menu/break_fast_screen.dart';
import 'menu/drink_screen.dart';
import 'menu/hookah_screen.dart';
import 'menu/mean_meal_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key, required String? userId});

  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 43, 171, 196),
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Menu Page",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          /*actions: [
            const Icon(
              Icons.menu_rounded,
              color: Colors.black,
            ),
            SizedBox(
              width: width * .03,
            )
          ],*/
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * .05, vertical: hight * .01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: hight * .8167,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: menu.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: hight * .01),
                        height: hight * .143,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: blackAppColor,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 255, 255, 255))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: hight * .12,
                              width: width * .37,
                              decoration: BoxDecoration(
                                  color: whiteAppColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Image.asset(
                                height: hight * 1.1,
                                menu[index]["img"].toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              menu[index]["title"],
                              style: const TextStyle(
                                  color: shadowAppColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            InkWell(
                              onTap: () {
                                menu[index]["id"] == 1
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BreakfastScreen()))
                                    : menu[index]["id"] == 2
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeanMaleScreen()))
                                        : menu[index]["id"] == 3
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DrinkScreen()))
                                            : menu[index]["id"] == 4
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const SweetScreen()))
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HookahScreen()));
                              },
                              child: Container(
                                width: width * .20,
                                height: hight * .04,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 43, 171, 196),
                                ),
                                child: const Center(
                                    child: Text(
                                  "GO to list",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                )),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
