// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'aboutus.dart';
import 'auth_functions.dart';
import 'adminsettingspage.dart';

class TablesInfo1 extends StatefulWidget {
  const TablesInfo1({Key? key, String? adminId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TablesInfo1State();
  }
}

class TablesInfo1State extends State<TablesInfo1> {
  // List to keep track of the color for each inner container
  List<Color> innerContainerColors = List.generate(6, (index) => Colors.white);

  // Function to update the color of the inner container based on the selected option
  void updateInnerContainerColor(int index, String option) {
    setState(() {
      switch (option) {
        case "Available soon":
          innerContainerColors[index] = Colors.yellow;
          break;
        case "Available":
          innerContainerColors[index] = Colors.green;
          break;
        case "Not Available":
          innerContainerColors[index] = Colors.red;
          break;
        default:
          innerContainerColors[index] = Colors.white;
      }
    });
  }

  void updateTableStatus(int index) {
    // Get the reference to the Restaurant collection
    CollectionReference restaurantCollection =
        FirebaseFirestore.instance.collection('Restaurant');

    // Get the current user's admin ID
    String? adminId = Provider.of<AdminData>(context, listen: false).adminId;

    // Create the update data for the specific table in the tablescapacity array
    Map<String, dynamic> updateData = {
      'tablescapacity.$index.tablestatus.Not Available': true,
      'tablescapacity.$index.tablestatus.Available': false,
    };

    // Update the document in Firestore
    restaurantCollection
        .doc('EbspzWo6KoFSgFIAY32l')
        .update(updateData)
        .then((value) {
      print('Table status updated successfully!');
      // Perform any additional actions if needed
    }).catchError((error) {
      print('Failed to update table status: $error');
      // Handle any errors that occurred during the update
    });
  }

  void updateTableStatus1(int index) {
    // Get the reference to the Restaurant collection
    CollectionReference restaurantCollection =
        FirebaseFirestore.instance.collection('Restaurant');

    // Get the current user's admin ID
    String? adminId = Provider.of<AdminData>(context, listen: false).adminId;

    // Create the update data for the specific table in the tablescapacity array
    Map<String, dynamic> updateData = {
      'tablescapacity.$index.tablestatus.Not Available': false,
      'tablescapacity.$index.tablestatus.Available': true,
    };

    // Update the document in Firestore
    restaurantCollection
        .doc('EbspzWo6KoFSgFIAY32l')
        .update(updateData)
        .then((value) {
      print('Table status updated successfully!');
      // Perform any additional actions if needed
    }).catchError((error) {
      print('Failed to update table status: $error');
      // Handle any errors that occurred during the update
    });
  }

  @override
  Widget build(BuildContext context) {
    String? adminId = Provider.of<AdminData>(context).adminId;

    User? admin = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.white54,
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
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
              accountName: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Admin')
                    .doc(admin?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text(
                      'Loading...',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                      ),
                    );
                  }

                  var adminData =
                      snapshot.data!.data() as Map<String, dynamic>?;
                  String adminName = adminData!['adminname'];

                  return Text(
                    adminName,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                    ),
                  );
                },
              ),
              accountEmail: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Admin')
                    .doc(admin?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text(
                      'Loading...',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                      ),
                    );
                  }

                  var adminData =
                      snapshot.data!.data() as Map<String, dynamic>?;
                  String adminEmail = adminData?['adminemail'];

                  return Text(
                    adminEmail,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  );
                },
              ),
            ),
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
                      builder: (context) => SettingsPage(adminId: adminId)),
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
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Tables Information",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2babc4),
      ),
      body: GridView.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Available soon'),
                          onTap: () {
                            updateInnerContainerColor(index, 'Available soon');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('Available'),
                          onTap: () {
                            updateTableStatus1(index);
                            updateInnerContainerColor(index, 'Available');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('Not Available'),
                          onTap: () {
                            updateTableStatus(index);
                            updateInnerContainerColor(index, 'Not Available');
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3.0,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: innerContainerColors[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
