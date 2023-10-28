import 'package:club_hub/Pages/LoginAndSignup/login.dart';
import 'package:club_hub/Pages/home/activity.dart';
import 'package:club_hub/Pages/home/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage(currentIndex: 1);
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}

class HomePage extends StatefulWidget {
  final int currentIndex;
  const HomePage({super.key, required this.currentIndex});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int currentIndex;
  final List<Widget> _pages = [
    const ActivityPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        currentIndex: currentIndex,
        selectedIconTheme: const IconThemeData(color: Colors.blue),
        selectedFontSize: 14,
        selectedItemColor: const Color.fromARGB(255, 0, 140, 255),
        unselectedItemColor: Colors.black,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
