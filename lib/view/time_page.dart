import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islom/bloc/time_bloc/time_bloc.dart';
import 'package:islom/bloc/time_bloc/time_state.dart';
import 'package:islom/utils/colors/colors.dart';
import 'package:islom/utils/list.dart';
import 'package:lottie/lottie.dart';

class TimePage extends StatefulWidget {
  const TimePage({super.key});

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: CustomColors.background,
        body: BlocBuilder<PrayerTimeBloc, PrayerTimeState>(
          builder: (context, state) {
            if (state is PrayerTimeLoading) {
              return Center(child: LottieBuilder.asset('assets/lotties/loading.json', width: width * 0.3, height: height * 0.3));
            } else if (state is PrayerTimeLoaded) {
              final prayerTime = state.prayerTime;
              return Stack(
                children: [
                  Container(
                    color: CustomColors.background,
                  ),
                  Positioned(
                    top: height * 0.1,
                    left: width * .27,
                    right: width * 0,
                    bottom: height * 0.55,
                    child: Text(prayerTime.readableDate,
                        style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                  ),
                  Positioned(
                    top: height * .32,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: SizedBox(
                      height: height * .2,
                      child: Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              itemCount: IconList.iconList.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                  child: Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: CustomColors.tile),
                                    width: width * 0.9,
                                    height: height * 0.07,
                                    child: Row(
                                      children: [
                                        SizedBox(width: width * .05),
                                        IconList.iconList[index],
                                        SizedBox(width: width * .05),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              TimeNames.timeNames[index],
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                                            ),
                                            Text(
                                              '12:00 AM',
                                              style: TextStyle(fontFamily: 'Quicksand', color: Colors.white),
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        IconButton(onPressed: () => {}, icon: Icon(Icons.notifications_none_outlined, color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else if (state is PrayerTimeError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text("Press the button to load data"));
            }
          },
        ));
  }
}
