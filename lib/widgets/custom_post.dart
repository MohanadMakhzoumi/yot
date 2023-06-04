import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomPost extends StatelessWidget {
  String? text;
  // ignore: prefer_typing_uninitialized_variables
  var img;
  VoidCallback? onpressed;
  CustomPost({
    super.key,
    this.text,
    this.img,
    this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;

    return Container(
      height: hight * .35,
      margin: EdgeInsets.symmetric(vertical: hight * .01),
      decoration: BoxDecoration(
          border: Border.all(
              width: 3, color: const Color.fromARGB(255, 255, 255, 255)),
          color: const Color.fromARGB(255, 0, 0, 0),
          borderRadius: BorderRadius.circular(7)),
      child: Column(
        children: [
          SizedBox(
            height: hight * .23,
            width: double.infinity,
            child: Image.asset(
              img,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text(
                      "Restuarant Name",
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const Text(
                      "Restuarant Place |",
                      style:
                          TextStyle(color: Color.fromARGB(255, 43, 171, 196)),
                    ),
                    Text(
                      "$text",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 43, 171, 196)),
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onpressed,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 43, 171, 196),
                    )),
                    child: const Row(
                      children: [
                        Icon(Icons.add, color: Colors.black),
                        Text("Reserve",
                            style: TextStyle(color: Colors.black, fontSize: 16))
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
