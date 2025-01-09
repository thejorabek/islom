import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:islom/utils/colors/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColors.background,
      body: Padding(
              padding: EdgeInsets.only(left: width * .07, right: width * .07, top: height * .12, bottom: height * .01),
              child: Column(
                children: [
                  Text(
                    'Quran App',
                    style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700,fontFamily: 'Quicksand'),
                  ),
                  SizedBox(height: height * .02),
                  Text(
                    'Learn Quran and\nRecite once everyday',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400,fontFamily: 'Quicksand'),
                  ),
                  SizedBox(height: height * .05),
                  SizedBox(
                      width: width * 1,
                      height: height * .7,
                      child: Stack(children: [
                        Container(
                            decoration: BoxDecoration(color: CustomColors.tile, borderRadius: BorderRadius.circular(30)),
                            width: width * 1,
                            height: height * .6,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: width * .09, top: height * .3),
                                  child: SvgPicture.asset('assets/svg/book.svg'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * .07, top: height * .02),
                                  child: SvgPicture.asset('assets/svg/stars.svg'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height * .1),
                                  child: SvgPicture.asset('assets/svg/clouds.svg'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: width * .67, top: height * .2),
                                  child: SvgPicture.asset('assets/svg/cloud.svg'),
                                )
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(left: width * .18, top: height * .56),
                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                              width: width * .5,
                              height: height * .07,
                              child: Center(
                                  child: Text(
                                'Get Started',
                                style: TextStyle(color: Color(0xFF091945), fontSize: 18, fontWeight: FontWeight.w600,fontFamily: 'Quicsand'),
                              )),
                            ),
                            onTap: () {
                              context.go('/main');
                            },
                          ),
                        )
                      ]))
                ],
              ),
            )
    );
  }
}