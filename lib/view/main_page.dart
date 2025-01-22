import 'package:flutter/material.dart';
import 'package:islom/utils/colors/colors.dart';
import 'package:islom/view/dua_page.dart';
import 'package:islom/view/fasting_page.dart';
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
  int selectedIndex = 0;
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          QuranPage(),
          FastingPage(),
          DuaPage(),
          TimePage(),
        ],
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: CustomColors.background,
        onButtonPressed: (index) {
          setState(() {
            selectedIndex = index;
          });
          _controller.animateToPage(selectedIndex, duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
        },
        iconSize: 30,
        activeColor: Colors.white,
        selectedIndex: selectedIndex,
        barItems: [
          BarItem(
            widget: Image.asset(
              'assets/images/quran.png',
              width: width * .11,
              height: height * .11,
              color: Colors.white,
            ),
            title: 'Quran',
          ),
          BarItem(
            widget: Image.asset(
              'assets/images/fasting.png',
              width: width * .11,
              height: height * .11,
              color: Colors.white,
            ),
            title: 'Fasting',
          ),
          BarItem(
            widget: Image.asset(
              'assets/images/dua.png',
              width: width * .11,
              height: height * .11,
              color: Colors.white,
            ),
            title: 'Dua',
          ),
          BarItem(
            widget: Image.asset(
              'assets/images/time.png',
              width: width * .11,
              height: height * .11,
              color: Colors.white,
            ),
            title: 'Time',
          ),
        ],
      ),
    );
  }
}
