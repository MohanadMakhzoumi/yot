import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/consts/tabel_pic_Screen.dart';
import 'package:restuarant/views/screens/menu_screen.dart';

import '../../consts/List.dart';
import '../../consts/colors.dart';
import '../../consts/images.dart';
import '../../main.dart';

class RestaurantName extends StatelessWidget {
  const RestaurantName({super.key, required String? userId});

  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color.fromARGB(255, 43, 171, 196),
        title: const Text(
          "Restuarant Name",
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: hight * .5,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: category.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (category[index]["id"] == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenuScreen(userId: userId)),
                      );
                    } else if (category[index]["id"] == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TabelPicScreen(userId: userId)),
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(width * .02),
                    padding: EdgeInsets.all(width * .031),
                    height: hight * .4,
                    width: width * .73,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          width: 3),
                      color: const Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: hight * .37,
                          width: width * .7,
                          foregroundDecoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7)),
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(100)),
                          child: Image.asset(
                            category[index]["img"].toString(),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text(
                          category[index]["title"].toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: width * .11, vertical: hight * .01),
            height: hight * .25,
            width: width * .77,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  r3,
                  fit: BoxFit.cover,
                ),
                const Text(
                  "Restaurant Name",
                  style: TextStyle(
                      color: shadowAppColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
