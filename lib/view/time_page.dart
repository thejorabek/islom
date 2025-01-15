import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islom/bloc/time_bloc/time_bloc.dart';
import 'package:islom/bloc/time_bloc/time_state.dart';
import 'package:islom/models/time_model.dart';
import 'package:islom/utils/colors/colors.dart';
import 'package:islom/utils/list.dart';
import 'package:lottie/lottie.dart';
import '../service/notification_service.dart';

class TimePage extends StatefulWidget {
  const TimePage({super.key});

  @override
  State<TimePage> createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  Timer? _prayerCheckTimer;
  TimeModel? _currentPrayerTime;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _startPrayerTimeCheck();
  }

  Future<void> _initializeNotifications() async {
    await NotificationService.initialize();
    await NotificationService.requestPermissions();
  }

  void _startPrayerTimeCheck() {
    _prayerCheckTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      if (_currentPrayerTime != null) {
        _checkAndNotifyPrayerTime(_currentPrayerTime!);
      }
    });
  }

  void _checkAndNotifyPrayerTime(TimeModel prayerTime) {
    final now = DateTime.now();
    final currentTime = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
    
    final timings = prayerTime.data.timings;
    final timeNames = TimeNames.timeNames;

    for (int index = 0; index < timeNames.length; index++) {
      final prayerName = timeNames[index];
      final prayerTime = GetTimes.getTiming(timings, prayerName);
      
      if (prayerTime == currentTime) {
        NotificationService.showNotification(
          id: index,
          title: 'Prayer Time',
          body: 'It is time for $prayerName prayer',
        );
      }
    }
  }

  String formatTimezone(String timezone) {
    final location = timezone.split('/').last;
    return location.replaceAll('_', ' ');
  }

  @override
  void dispose() {
    _prayerCheckTimer?.cancel();
    super.dispose();
  }

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
              _currentPrayerTime = prayerTime;
              return Stack(
                children: [
                  Container(
                    color: CustomColors.background,
                  ),
                  Positioned(
                    top: height * 0.1,
                    right: width * .24,
                    bottom: height * 0.55,
                    child: Column(
                      children: [
                        Text(prayerTime.data.date.readable,
                            style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                        Text(
                          '${prayerTime.data.date.hijri.weekday.ar} - ${prayerTime.data.date.gregorian.weekday.en}',
                          style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: height * .05),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded, size: 30, color: Colors.white),
                            SizedBox(width: width * .05),
                            Text(
                              formatTimezone(prayerTime.data.meta.timezone),
                              style: TextStyle(fontFamily: 'Quicksand', fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
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
                                              GetTimes.getTiming(prayerTime.data.timings, TimeNames.timeNames[index]),
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
              return Center(child: Text("Error on loading time for current location"));
            }
          },
        ));
  }
}
