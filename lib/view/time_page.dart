import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islom/bloc/time_bloc/time_bloc.dart';
import 'package:islom/bloc/time_bloc/time_state.dart';
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
    return Scaffold(body: BlocBuilder<PrayerTimeBloc, PrayerTimeState>(
      builder: (context, state) {
        if (state is PrayerTimeLoading) {
          return Center(child: LottieBuilder.asset('assets/lotties/loading.json', width: width * 0.3, height: height * 0.3));
        } else if (state is PrayerTimeLoaded) {
          final prayerTime = state.prayerTime;
          return Stack(
            children: [
              Container(
                color: Colors.indigo,
              ),
              Positioned(
                top: height * 0,
                left: width * 0,
                right: width * 0,
                bottom: height * 0.55,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70), bottomRight: Radius.circular(70))),
                  child: Image.asset(
                    "assets/images/mosque.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
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
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
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
                                          prayerTime.readableDate,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                        ),
                                        Text('12:00 AM',style: TextStyle(fontFamily: 'Quicksand'),)
                                      ],
                                    ),
                                    Spacer(),
                                    IconButton(onPressed: () => {}, icon: Icon(Icons.notifications_none_outlined)),
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
