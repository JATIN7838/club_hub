import 'package:club_hub/Pages/announcements/new.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Image(
            image: const AssetImage('assets/logo.png'),
            height: size.height * 0.15,
            width: size.width * 0.6,
            fit: BoxFit.fill,
          ),
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NewAnnouncePage())),
            child: Container(
              color: const Color.fromARGB(255, 122, 122, 122),
              height: size.height * 0.2,
              width: size.width * 0.7,
              child: const Center(child: Text('New Announcement')),
            ),
          ),
          Container(
            color: const Color.fromARGB(255, 122, 122, 122),
            height: size.height * 0.2,
            width: size.width * 0.7,
            child: const Center(child: Text('Edit Announcement')),
          ),
          Container(
            color: const Color.fromARGB(255, 122, 122, 122),
            height: size.height * 0.2,
            width: size.width * 0.7,
            child: const Center(child: Text('Delete Announcement')),
          ),
        ]),
      ),
    );
  }
}
