import 'package:club_hub/Pages/LoginAndSignup/login.dart';
import 'package:club_hub/Pages/home/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Auth extends GetxController {
  late Rx<User?> _user;
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const ProfilePage());
    }
  }

  static savetofirestore(String? name, email, uid) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({'email': email, 'name': name, 'profileType': 'user'});
  }

  static Future<String> signupUser(
      String email, String password, String name) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());
      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await savetofirestore(name, email, userCredential.user!.uid);
      return 'Welcome!!';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> signinUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return 'Signed in';
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return 'Signed Out';
    } catch (error) {
      return error.toString();
    }
  }
}
