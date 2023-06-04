import 'package:flutter/material.dart';
import 'package:restuarant/views/screens/menu/basket.dart';

import '../../../consts/List.dart';
import '../../../consts/colors.dart';

class SweetScreen extends StatefulWidget {
  const SweetScreen({super.key});

  @override
  State<SweetScreen> createState() => _SweetScreenState();
}

class _SweetScreenState extends State<SweetScreen> {
  late SnackBar snackBar;
  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color.fromARGB(255, 43, 171, 196),
        title: const Text(
          "Sweets",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        /*centerTitle: true,
        actions: [
          const Icon(
            Icons.add_alert_sharp,
            color: orangeAppColor,
          ),
          SizedBox(
            width: width * .03,
          )
        ],*/
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: hight * 0.3,
                    crossAxisSpacing: width * 0.0231,
                    crossAxisCount: 2),
                itemCount: pageSweet.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * .01, vertical: hight * .01),
                    margin: EdgeInsets.symmetric(
                        vertical: hight * .01, horizontal: width * .04),
                    height: hight * .2,
                    width: width * .4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            width: 3)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            pageSweet[index]["img"],
                          ),
                          radius: hight * .07,
                        ),
                        Text(
                          pageSweet[index]["title"],
                          style: const TextStyle(
                              color: shadowAppColor,
                              fontWeight: FontWeight.w500),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              snackBar = SnackBar(
                                backgroundColor:
                                    const Color.fromARGB(255, 255, 255, 255),
                                content: const Text(
                                  'Itme has added to basket',
                                  style: TextStyle(color: Colors.black),
                                ),
                                action: SnackBarAction(
                                  textColor:
                                      const Color.fromARGB(255, 43, 171, 196),
                                  label: 'Go to basket',
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Basket()));
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 43, 171, 196),
                            )),
                            child: const Icon(
                              Icons.add,
                              color: Colors.black,
                            ))
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
