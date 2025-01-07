import 'package:flutter/material.dart';
import 'package:islom/view/dua_page.dart';
import 'package:islom/view/hadis_page.dart';
import 'package:islom/view/quran_page.dart';
import 'package:islom/view/time_page.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  int selectedIndex = 0;
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          QuranPage(),
          HadisPage(),
          DuaPage(),
          TimePage(),
        ],
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.white,
        onButtonPressed: (index) {
          setState(() {
            selectedIndex = index;
          });
          _controller.animateToPage(selectedIndex, duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
        },
        iconSize: 30,
        activeColor: Color(0xFF01579B),
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            icon: Icons.book_outlined,
            title: 'Quran',
          ),
          BarItem(
            icon: Icons.menu_book_outlined,
            title: 'Hadis',
          ),
          BarItem(
            icon: Icons.back_hand_outlined,
            title: 'Dua',
          ),
          BarItem(
            icon: Icons.access_time_outlined,
            title: 'Time',
          ),
        ],
      ),
    );
  }
}
