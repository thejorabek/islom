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
  StreamController<String>? _countdownController;
  Timer? _countdownTimer;
  String? _currentPrayer;

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

  void _startDynamicCountdown(Timings timings) {
    _countdownController?.close();
    _countdownTimer?.cancel();

    _countdownController = StreamController<String>();
    String? prevNextPrayerTime;
    String? currentPrayer;

    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final nextPrayerTime = _getNextPrayerTime(timings);

      if (prevNextPrayerTime != nextPrayerTime) {
        prevNextPrayerTime = nextPrayerTime;
      }

      final timeParts = nextPrayerTime.split(':');
      final prayerHour = int.parse(timeParts[0]);
      final prayerMinute = int.parse(timeParts[1]);

      DateTime prayerDateTime = DateTime(now.year, now.month, now.day, prayerHour, prayerMinute);
      if (prayerDateTime.isBefore(now)) {
        prayerDateTime = prayerDateTime.add(Duration(days: 1));
      }

      final remaining = prayerDateTime.difference(now);
      final hours = remaining.inHours;
      final minutes = remaining.inMinutes.remainder(60);
      final seconds = remaining.inSeconds.remainder(60);

      _countdownController?.add(
        '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}',
      );

      final newCurrentPrayer = getCurrentPrayer(timings);
      if (newCurrentPrayer != currentPrayer) {
        currentPrayer = newCurrentPrayer;
        if (mounted) {
          setState(() {
            _currentPrayer = newCurrentPrayer;
          });
        }
      }
    });
  }

  String _getNextPrayerTime(Timings timings) {
    final now = DateTime.now();
    final timeNames = TimeNames.timeNames;

    for (final prayerName in timeNames) {
      final prayerTime = GetTimes.getTiming(timings, prayerName);
      final timeparts = prayerTime.split(':');
      final prayerDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(timeparts[0]),
        int.parse(timeparts[1]),
      );

      if (prayerDateTime.isAfter(now)) {
        return prayerTime;
      }
    }

    final firstPrayerTime = GetTimes.getTiming(timings, timeNames.first);
    final timeparts = firstPrayerTime.split(':');
    final tomorrowPrayerDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(timeparts[0]),
      int.parse(timeparts[1]),
    ).add(Duration(days: 1));
    return '${tomorrowPrayerDateTime.hour.toString().padLeft(2, '0')}:${tomorrowPrayerDateTime.minute.toString().padLeft(2, '0')}';
  }

  String formatTimezone(String timezone) {
    final location = timezone.split('/').last;
    return location.replaceAll('_', ' ');
  }

  String getCurrentPrayer(Timings timings) {
    final now = DateTime.now();
    final times = TimeNames.timeNames.map((name) {
      final time = GetTimes.getTiming(timings, name);
      final parts = time.split(':');
      return DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
    }).toList();

    for (int i = 0; i < times.length - 1; i++) {
      if (now.isAfter(times[i]) && now.isBefore(times[i + 1])) {
        return TimeNames.timeNames[i];
      }
    }
    return TimeNames.timeNames.last;
  }

  @override
  void dispose() {
    _prayerCheckTimer?.cancel();
    _countdownController?.close();
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: CustomColors.background,
        title: Text('Time', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Quicksand')),
        centerTitle: true,
      ),
      backgroundColor: CustomColors.background,
      body: BlocBuilder<PrayerTimeBloc, PrayerTimeState>(
        builder: (context, state) {
          if (state is PrayerTimeLoading) {
            return Center(child: Lottie.asset('assets/lotties/loading.json', width: width * 0.7, height: height * 0.7));
          } else if (state is PrayerTimeLoaded) {
            final prayerTime = state.prayerTime;
            _currentPrayerTime = prayerTime;
            if (_currentPrayer == null) {
              _currentPrayer = getCurrentPrayer(prayerTime.data.timings);
            }
            _startDynamicCountdown(prayerTime.data.timings);
            return Stack(
              children: [
                Container(color: CustomColors.background),
                Positioned(
                  top: height * .001,
                  right: width * .24,
                  bottom: height * 0.5,
                  child: Column(
                    children: [
                      Text(prayerTime.data.date.readable,
                          style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                      Text(
                        '${prayerTime.data.date.hijri.weekday.ar} - ${prayerTime.data.date.gregorian.weekday.en}',
                        style: TextStyle(fontFamily: 'Quicksand', color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: height * .02),
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded, size: 30, color: Colors.white),
                          SizedBox(width: width * .05),
                          Text(
                            formatTimezone(prayerTime.data.meta.timezone),
                            style: TextStyle(fontFamily: 'Quicksand', fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: height * .015),
                      StreamBuilder<String>(
                        stream: _countdownController?.stream,
                        initialData: '--:--:--',
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.data ?? '',
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: height * .26,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: SizedBox(
                    height: height * .2,
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: IconList.iconList.length,
                            itemBuilder: (context, index) {
                              final prayerName = TimeNames.timeNames[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _currentPrayer == prayerName
                                        ? Colors.green
                                        : Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
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
                                            prayerName,
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                                          ),
                                          Text(
                                            GetTimes.getTiming(prayerTime.data.timings, prayerName),
                                            style: TextStyle(fontFamily: 'Quicksand', color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.notifications_none_outlined, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          } else if (state is PrayerTimeError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text("Error loading prayer times"));
          }
        },
      ),
    );
  }
}