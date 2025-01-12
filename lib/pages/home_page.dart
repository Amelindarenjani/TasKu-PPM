import 'package:belajar_mobile/components/bottom_navbar.dart';
import 'package:belajar_mobile/pages/note_page.dart';
import 'package:belajar_mobile/pages/pomodoro_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // sign out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const NotePage(),
    const PomodoroPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'NotApp',
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary),
              child: Text(
                user.email!,
                style: TextStyle(fontSize: 12),
              ),
            ),
            IconButton(
              onPressed: signUserOut,
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ],
        ),

        // bottom navbar
        bottomNavigationBar: BottomNavbar(
          onTabChange: (index) => navigateBottomBar(index),
        ),

        // body
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _pages[_selectedIndex],
        ),
      ),
    );
  }
}
