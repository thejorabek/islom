import 'package:flutter/material.dart';
import 'package:islom/utils/colors/colors.dart';
import 'package:islom/utils/list.dart';
import 'dart:async';

class FastingPage extends StatefulWidget {
  const FastingPage({super.key});

  @override
  _FastingPageState createState() => _FastingPageState();
}

class _FastingPageState extends State<FastingPage> {
  late StreamController<String> _timeController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timeController = StreamController<String>();
    _startClock();
  }

  void _startClock() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final timeString = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
      _timeController.add(timeString);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _timeController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List flist = FastingList.fastingTime;
    int isToday = DateTime.now().day;
    int isMonth = DateTime.now().month;
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                          'Suhoor',
                          style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        SizedBox(height: height * .01),
                        Text('${flist[0]['saharlik']}', style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30))
                      ],
                    ),
                    StreamBuilder<String>(
                      stream: _timeController.stream,
                      initialData: '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.data ?? '',
                          style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 60),
                        );
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Iftar',
                          style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        SizedBox(height: height * .01),
                        Text('${flist[0]['iftorlik']}', style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: height * .03),
            Container(
              width: width * .9,
              height: height * .61,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
              child: Column(
                children: [
                  SizedBox(
                    height: height * .61,
                    child: ListView.builder(
                        itemCount: 30,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: height * .01, left: width * .02, right: width * .02),
                            child: Container(
                              height: height * .05,
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(15), color: isToday == index && isMonth==3 ? Colors.white : Colors.transparent),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: width * .01),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: width * .08,
                                      height: height * .04,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: CustomColors.tile),
                                      child: Center(
                                        child: Text('${index + 1}',
                                            style:
                                                TextStyle(fontFamily: 'Quicksand', fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    Container(
                                      width: width * .15,
                                      height: height * .04,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: CustomColors.tile),
                                      child: Center(
                                        child: Text(
                                          flist[index]['oy'],
                                          style: TextStyle(fontFamily: 'Quiksand', fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * .15,
                                      height: height * .04,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: CustomColors.tile),
                                      child: Center(
                                        child: Text(
                                          flist[index]['haftaKuni'],
                                          style: TextStyle(fontFamily: 'Quiksand', fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * .15,
                                      height: height * .04,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: CustomColors.tile),
                                      child: Center(
                                        child: Text(
                                          flist[index]['saharlik'],
                                          style: TextStyle(fontFamily: 'Quiksand', fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: width * .15,
                                      height: height * .04,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: CustomColors.tile),
                                      child: Center(
                                        child: Text(
                                          flist[index]['iftorlik'],
                                          style: TextStyle(fontFamily: 'Quiksand', fontSize: 20, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
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
