import 'package:flutter/material.dart';
import 'package:islom/utils/colors/colors.dart';

class FastingPage extends StatelessWidget {
  const FastingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        backgroundColor: CustomColors.background,
        centerTitle: true,
        title: Text(
          'Fasting',
          style: TextStyle(color: Colors.white, fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: width * .9,
              height: height * .13,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: CustomColors.tile),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'First',
                          style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        SizedBox(height: height * .01),
                        Text('06:03', style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30))
                      ],
                    ),
                    Text(
                      '15:45',
                      style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 60),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Second',
                          style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        SizedBox(height: height * .01),
                        Text('17:22', style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * .015),
            Container(
              width: width * .9,
              height: height * .05,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)), color: Colors.white),
              child: Row(
                children: [],
              ),
            ),
            SizedBox(height: height * .015),
            Container(
              width: width * .9,
              height: height * .61,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: CustomColors.tile),
              child: Column(
                children: [
                  SizedBox(
                    height: height * .56,
                    child: ListView.builder(
                        itemCount: 30,
                        itemBuilder: (context, index) {
                          return index.isEven
                              ? Padding(
                                  padding: EdgeInsets.only(top: height * .01, left: width * .02, right: width * .02),
                                  child: Container(
                                    height: height * .05,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.white),
                                    child: Row(
                                      children: [
                                        SizedBox(width: width * .01),
                                        CircleAvatar(
                                          child: Text('${index + 1}',
                                              style: TextStyle(
                                                  fontFamily: 'Quicksand',
                                                  fontSize: 20,
                                                  color: index.isEven ? Colors.black : Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        Divider()
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: height * .05,
                                  child: Row(
                                    children: [
                                      SizedBox(width: width * .03),
                                      CircleAvatar(
                                        child: Text('${index + 1}',
                                            style: TextStyle(
                                                fontFamily: 'Quicksand',
                                                fontSize: 20,
                                                color: index.isEven ? Colors.black : Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      Divider()
                                    ],
                                  ));
                        }),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
