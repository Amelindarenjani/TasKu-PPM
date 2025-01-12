import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavbar extends StatelessWidget {
  final void Function(int)? onTabChange;
  const BottomNavbar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        child: GNav(
            color: Colors.grey.shade700,
            activeColor: Theme.of(context).colorScheme.secondary,
            tabBackgroundColor: Theme.of(context).colorScheme.inversePrimary,
            tabActiveBorder: Border.all(color: Colors.white),
            mainAxisAlignment: MainAxisAlignment.center,
            tabBorderRadius: 50,
            onTabChange: (value) => onTabChange!(value),
            tabs: const [
              GButton(
                icon: Icons.list,
                text: 'Todo',
              ),
              GButton(
                icon: Icons.timer,
                text: 'Timer',
              ),
            ]));
  }
}
