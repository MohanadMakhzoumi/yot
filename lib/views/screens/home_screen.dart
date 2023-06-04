import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restuarant/UI/aboutus.dart';
import 'package:restuarant/UI/auth_functions.dart';
import 'package:restuarant/UI/feedbackpage.dart';

import 'package:restuarant/views/screens/restaurant_name.dart';

import '../../consts/List.dart';
import '../../consts/images.dart';
import '../../main.dart';
import '../../usersettingspage.dart';
import '../../widgets/custom_post.dart';
import '../../widgets/custom_search.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required String? userId});

  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
          child: Column(
        children: [
          const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 43, 171, 196),
              ),
              accountName: Text("Name",
                  style: TextStyle(color: Colors.black, fontSize: 20)),
              accountEmail: Text("email@domain.xx",
                  style: TextStyle(color: Colors.black, fontSize: 16))),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: const Text("Settings",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsPage(userId: userId)),
              );
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          ),
          const ListTile(
            leading: Icon(
              Icons.table_bar,
              color: Colors.black,
            ),
            title: Text("My Reservations",
                style: TextStyle(color: Colors.black, fontSize: 20)),
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          ),
          ListTile(
            leading: const Icon(
              Icons.feedback,
              color: Colors.black,
            ),
            title: const Text("Feedback",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FeedbackPage(userId: userId)),
              );
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: Text("Logout",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              signOutUser(context);
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          ),
          ListTile(
            leading: const Icon(
              Icons.question_mark,
              color: Colors.black,
            ),
            title: const Text("About Us",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          ),
          const ListTile(
            leading: Icon(
              Icons.share,
              color: Colors.black,
            ),
            title: Text("Share App",
                style: TextStyle(color: Colors.black, fontSize: 20)),
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          )
        ],
      )),
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color.fromARGB(255, 43, 171, 196),
          title: const Text(
            "Recommended",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * .06,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: CustomSearch(
                    text: "Search for Restaurant here...",
                    fontsize: 13.5,
                  ),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 30,
                child: Text(
                  ' Sort By',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: hight * .15,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: title.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: width * .01, vertical: 10),
                        height: hight * .1,
                        width: width * .27,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Text(
                            title[index],
                            style: const TextStyle(
                                color: Color.fromARGB(115, 0, 0, 0),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 35,
                child: Text(
                  'Restaurants',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 22),
                ),
              ),
              CustomPost(
                onpressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RestaurantName(userId: userId)),
                  );
                },
                text: "Indoor/Outdoor",
                img: r1,
              ),
              CustomPost(
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RestaurantName(userId: userId)),
                    );
                  },
                  text: "Indoor",
                  img: r2),
              CustomPost(
                  onpressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RestaurantName(userId: userId)),
                    );
                  },
                  text: "Outdoor",
                  img: r3),
            ],
          ),
        ),
      ),
    );
  }
}
