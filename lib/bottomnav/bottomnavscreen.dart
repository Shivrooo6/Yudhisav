import 'package:flutter/material.dart';
import 'package:yudhisav/complaints/help.dart';
import 'package:yudhisav/historyscreen.dart';
// Ensure this path matches the actual file location
import 'package:yudhisav/home/homescreen.dart';
import 'package:yudhisav/user/userscreen.dart';

class BottomNavScreen extends StatefulWidget {
  final int initialIndex;

  const BottomNavScreen({super.key, this.initialIndex = 0});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  late int currentIndex;

  final List<String> icons = [
    "house.png",
    "history.png",
    "user.png",
    "circle-help.png",
  ];

  final List<String> labels = [
    "Home",
    "History",
    "User",
    "Help",
  ];

  late final List<Widget> pages;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;

    pages = [
      const HomeScreen(),
      const HistoryScreen(),
      const UserScreen(),
      const HelpScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            selectedItemColor: const Color.fromARGB(255, 0, 91, 128),
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: List.generate(icons.length, (index) {
              final imagePath = 'assets/images/${icons[index]}';
              return BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(imagePath),
                  size: 26,
                ),
                label: labels[index],
              );
            }),
          ),
        ),
      ),
    );
  }
}
