import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club_hub/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/auth.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  late ScaffoldMessengerState scaffoldMessenger;
  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 105, 104, 104),
                  Color.fromARGB(255, 62, 62, 62),
                  Colors.black
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const Image(
                  image: AssetImage('assets/logo.png'),
                  height: 200,
                  width: 200,
                  fit: BoxFit.contain,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.12,
                    ),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: size.width * 0.8,
                  height: 50,
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 150, 150, 150),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        )),
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width * 0.8,
                  height: 50,
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 150, 150, 150),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        )),
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: size.width * 0.8,
                  height: 50,
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 150, 150, 150),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        )),
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 40,
                  width: 120,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (nameController.text == '') {
                        scaffoldMessenger.showSnackBar(
                            const SnackBar(content: Text('Enter your name!')));
                      } else {
                        if (context.mounted) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          );
                        }
                        String val = await Auth.signupUser(emailController.text,
                            passwordController.text, nameController.text);
                        if (context.mounted) Navigator.pop(context);
                        if (val == 'success') {
                          String ptype = await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .get()
                              .then((value) =>
                                  value.data()!['profileType'].toString());

                          if (context.mounted) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage(
                                          currentIndex: 1,
                                          profileType: ptype,
                                        )));
                          }
                          val = 'Registration Successful';
                        }
                        scaffoldMessenger.showSnackBar(
                            SnackBar(content: Text(val.toString())));
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                googleLogin(context, size),
                SizedBox(height: size.height * 0.1),
                Container(
                  color: const Color.fromARGB(255, 62, 62, 62),
                  width: size.width,
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Already have an account ?',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  ElevatedButton googleLogin(BuildContext context, Size size) {
    return ElevatedButton(
      onPressed: () async {
        if (context.mounted) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          );
        }
        String val = await Auth.googleLogin();
        if (context.mounted) Navigator.pop(context);
        if (val == 'success') {
          String ptype = await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) => value.data()!['profileType'].toString());

          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  currentIndex: 0,
                  profileType: ptype,
                ),
              ),
            );
          }
          val = 'Registration Successful';
        } else if (val == 'first') {
          String ptype = await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) => value.data()!['profileType'].toString());

          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  currentIndex: 1,
                  profileType: ptype,
                ),
              ),
            );
          }
          val = 'Registration Successful';
        }
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(val.toString()),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: const Color(0xFF4E60FF),
        elevation: 8,
        padding: const EdgeInsets.symmetric(vertical: 10),
      ),
      child: const SizedBox(
        width: 250,
        height: 25,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.google,
              color: Colors.white,
            ),
            SizedBox(width: 5),
            Text(
              '  Continue with Google',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
