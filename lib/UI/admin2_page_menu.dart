import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/UI/aboutus.dart';
import 'package:restuarant/UI/adminsettingspage.dart';
import 'package:restuarant/consts/images.dart';
import '../main.dart';
import 'auth_functions.dart';
//import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class Menu2 extends StatefulWidget {
  const Menu2({super.key, String? adminId});

  @override
  State<StatefulWidget> createState() {
    return Menu2State();
  }
}

class Menu2State extends State<Menu2> {
  File? galleryFile;
  final picker = ImagePicker();

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? adminId = Provider.of<AdminData>(context).adminId;
    User? admin = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.black,
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

                var adminData = snapshot.data!.data() as Map<String, dynamic>?;
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

                var adminData = snapshot.data!.data() as Map<String, dynamic>?;
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
                MaterialPageRoute(builder: (context) => const AboutUsPage()),
              );
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          ),
        ],
      )),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Menu",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2babc4),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Row(
            children: <Widget>[
              //#1
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //1
                      const Text("Salad",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Container(
                        height: 20.0,
                      ),

                      //2
                      const CircleAvatar(
                        backgroundImage: AssetImage(b7),
                        radius: 80,
                      ),
                      const Text(
                        'Supreme Salad',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),

                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 2.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(b8),
                        radius: 80,
                      ),
                      const Text(
                        'CHICKEN BAKED PASTA',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),

                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 2.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(b9),
                        radius: 80,
                      ),
                      const Text(
                        'FOOT LONG LASAGNA',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),

                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 3.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(b10),
                        radius: 80,
                      ),
                      const Text(
                        'Resep Salad Buah Ala',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),

                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 2.0 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(b11),
                        radius: 80,
                      ),
                      const Text(
                        'Macaroni Cream Salad',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),

                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 3.0 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(b12),
                        radius: 80,
                      ),
                      const Text(
                        'One Entree Grand Salad',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),

                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 3.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      //3
                      /*Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 17.0),
                              primary: const Color(0xFF2babc4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          icon: const Icon(Icons.add_photo_alternate_outlined,
                              color: Colors.black),
                          label: const Text(
                            "Add Photo",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            _showPicker(context: context);
                          },
                        ),
                      )*/
                    ],
                  ),
                ),
              ),

              //#2
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: <Widget>[
                      //1
                      const Text("Main Meals",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Container(
                        height: 20.0,
                      ),
                      //2
                      const CircleAvatar(
                        backgroundImage: AssetImage(m7),
                        radius: 80,
                      ),
                      const Text(
                        'Margherita',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 3.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(m8),
                        radius: 80,
                      ),
                      const Text(
                        'BBQ Chicken',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 4.0 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(m9),
                        radius: 80,
                      ),
                      const Text(
                        'Spicy Chicken Ranch',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 3.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(m10),
                        radius: 80,
                      ),
                      const Text(
                        'Ulimate Cheese',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 3.0 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(m11),
                        radius: 80,
                      ),
                      const Text(
                        'BBQ Chicken Ranch Pizza',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 4.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(m12),
                        radius: 80,
                      ),
                      const Text(
                        'Veggie Ranch Sliced Pizza',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 3.0 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      //3
                      /* Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 17.0),
                              primary: const Color(0xFF2babc4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          icon: const Icon(Icons.add_photo_alternate_outlined,
                              color: Colors.black),
                          label: const Text("Add Photo",
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            _showPicker(context: context);
                          },
                        ),
                      )*/
                    ],
                  ),
                ),
              ),

              //#3
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: <Widget>[
                      //1
                      const Text("Drinks",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Container(
                        height: 20.0,
                      ),
                      //2
                      const CircleAvatar(
                        backgroundImage: AssetImage(d7),
                        radius: 80,
                      ),
                      const Text(
                        'Water',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 0.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(d8),
                        radius: 80,
                      ),
                      const Text(
                        '7up',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 0.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(d9),
                        radius: 80,
                      ),
                      const Text(
                        'Mirainda',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 0.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(d10),
                        radius: 80,
                      ),
                      const Text(
                        'Pepsi',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 0.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(d11),
                        radius: 80,
                      ),
                      const Text(
                        'DietPepsi',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 0.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(d12),
                        radius: 80,
                      ),
                      const Text(
                        'Fanta',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 0.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),

                      //3
                      /*Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 17.0),
                              primary: const Color(0xFF2babc4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          icon: const Icon(Icons.add_photo_alternate_outlined,
                              color: Colors.black),
                          label: const Text("Add Photo",
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            _showPicker(context: context);
                          },
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),

              //#4
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: <Widget>[
                      //1
                      const Text("Sweets",
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      Container(
                        height: 20.0,
                      ),
                      //2
                      const CircleAvatar(
                        backgroundImage: AssetImage(sw7),
                        radius: 80,
                      ),
                      const Text(
                        'Chocolate Kit Kat',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 5.0 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(sw8),
                        radius: 80,
                      ),
                      const Text(
                        'Hersey\'sCookie',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 4.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(sw9),
                        radius: 80,
                      ),
                      const Text(
                        'Profiteroles Box',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 4.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(sw10),
                        radius: 80,
                      ),
                      const Text(
                        'Mini Profiteroles Box',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 5.0,
                      ),
                      const Text(
                        'Price: 3.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(sw11),
                        radius: 80,
                      ),
                      const Text(
                        'Magnum Classic',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 4.0,
                      ),
                      const Text(
                        'Price: 4.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      const CircleAvatar(
                        backgroundImage: AssetImage(sw12),
                        radius: 80,
                      ),
                      const Text(
                        'Pizza Hut CinnamonRolls',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 3.0,
                      ),
                      const Text(
                        'Price: 4.5 JOD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                        height: 20.0,
                      ),
                      //3
                      /*Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              textStyle: const TextStyle(fontSize: 17.0),
                              primary: const Color(0xFF2babc4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                          icon: const Icon(Icons.add_photo_alternate_outlined,
                              color: Colors.black),
                          label: const Text("Add Photo",
                              style: TextStyle(color: Colors.black)),
                          onPressed: () {
                            _showPicker(context: context);
                          },
                        ),
                      )*/
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<String> getPhotoUrl(String adminId) async {
  DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('Admin').doc(adminId).get();
  Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  String photoUrl = data['Water']['itemsurl'];
  return photoUrl;
}
