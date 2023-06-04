// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/UI/adminsettingspage.dart';
import '../main.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, required String? adminId});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  bool passwordempty = false;
  final passwordController = TextEditingController();
  final passworddController = TextEditingController();
  final RegExp passwordd =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

  @override
  Widget build(BuildContext context) {
    String? adminId = Provider.of<AdminData>(context).adminId;
    var _password1;
    var _password2;
    GlobalKey<FormState> check = GlobalKey<FormState>();

    void resetPassword(String newPassword) async {
      try {
        // Get a reference to the Firestore collection
        CollectionReference adminRef =
            FirebaseFirestore.instance.collection('Admin');

        // Query for the document with the current user's ID
        QuerySnapshot querySnapshot = await adminRef.get();

        if (querySnapshot.docs.isNotEmpty) {
          // Get the first document from the query result
          DocumentSnapshot adminDoc = querySnapshot.docs[0];

          // Get the current password
          String currentPassword = adminDoc['adminpassword'];

          // Check if the new password is different from the current password
          if (newPassword != currentPassword) {
            // Update the password field with the new password
            await adminRef
                .doc(adminDoc.id)
                .update({'adminpassword': newPassword});

            print('Password reset successful');
            showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 75),
                    child: AlertDialog(
                        title: const Text(
                          'Done',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 32, 31, 31)),
                        ),
                        content: const Text(
                          'Your password has been reset successfully.',
                          style:
                              TextStyle(color: Color.fromARGB(255, 32, 31, 31)),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SettingsPage(adminId: adminId)));
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              )),
                        ]),
                  );
                });
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 75),
                    child: AlertDialog(
                        title: const Text(
                          'Failed',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 32, 31, 31)),
                        ),
                        content: const Text(
                          'New password must be different from the previous password.',
                          style:
                              TextStyle(color: Color.fromARGB(255, 32, 31, 31)),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SettingsPage(adminId: adminId)));
                              },
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              )),
                        ]),
                  );
                });
            print('New password must be different from the previous password');
          }
        }
      } catch (e) {
        // Handle any errors
        print('Error resetting password: $e');
      }
    }

    void Reset() {
      var checkfeild = check.currentState;
      if (checkfeild!.validate()) {
        checkfeild.save();
        resetPassword(passworddController.text);
      }
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBar: AppBar(
              title: const Text(
                'Reset Password',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              leading: IconButton(
                color: const Color.fromARGB(255, 255, 255, 255),
                icon: const Icon(
                  Icons.arrow_back,
                  //size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SettingsPage(adminId: adminId)));
                },
              ),
              backgroundColor: const Color(0xFF3C7021),
            ),
            body: Column(children: [
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: check,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: const Text(
                              'Your new password must be different from previous passwords.',
                              style: TextStyle(
                                  color: Color(0xFF3c7424),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                              width: 350,
                              child: TextFormField(
                                controller: passwordController,
                                onSaved: (text) {
                                  _password1 = text;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    passwordempty = false;
                                    return "Password can't be empty";
                                  } else if (passwordd.hasMatch(text)) {
                                    passwordempty = true;
                                    return null;
                                  } else {
                                    passwordempty = false;
                                    return 'Enter a stronger password';
                                  }
                                },
                                style:
                                    const TextStyle(color: Color(0xFF2c2c34)),
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible1
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: const Color(0xFF3c7424),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible1 =
                                              !_passwordVisible1;
                                        });
                                      },
                                    ),
                                    counterStyle: const TextStyle(
                                        color: Color(0xFF3c7424)),
                                    hintText: 'Enter your new password',
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF2c2c34)),
                                    labelText: 'New Password',
                                    labelStyle: const TextStyle(
                                        color: Color(0xFF3c7424),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF3c7424))),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF3c7424))),
                                    errorBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 142, 10, 14)))),
                                cursorColor: const Color(0xFF3c7424),
                                cursorHeight: 25,
                                maxLength: 20,
                                maxLines: 1,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                obscureText: !_passwordVisible1,
                              )),
                          SizedBox(
                              width: 350,
                              child: TextFormField(
                                controller: passworddController,
                                onSaved: (text) {
                                  _password2 = text;
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    passwordempty = false;
                                    return "Password can't be empty";
                                  } else if (passworddController.text !=
                                      passwordController.text) {
                                    passwordempty = false;
                                    return "Password don't match!";
                                  } else {
                                    passwordempty = true;
                                    return null;
                                  }
                                },
                                style:
                                    const TextStyle(color: Color(0xFF2c2c34)),
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _passwordVisible2
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: const Color(0xFF3c7424),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible2 =
                                              !_passwordVisible2;
                                        });
                                      },
                                    ),
                                    counterStyle: const TextStyle(
                                        color: Color(0xFF3c7424)),
                                    hintText: 'Re-enter your password',
                                    hintStyle: const TextStyle(
                                        color: Color(0xFF2c2c34)),
                                    labelText: 'Confirm Password',
                                    labelStyle: const TextStyle(
                                        color: Color(0xFF3c7424),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF3c7424))),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF3c7424))),
                                    errorBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 142, 10, 14)))),
                                cursorColor: const Color(0xFF3c7424),
                                cursorHeight: 25,
                                maxLength: 20,
                                maxLines: 1,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.done,
                                obscureText: !_passwordVisible2,
                              )),
                          Container(
                            padding: const EdgeInsets.only(top: 30),
                            child: SizedBox(
                                height: 50,
                                width: 150,
                                child: MaterialButton(
                                  color: const Color(0xFF3c7424),
                                  onPressed: () {
                                    Reset();
                                  },
                                  textColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ))
            ])));
  }
}
