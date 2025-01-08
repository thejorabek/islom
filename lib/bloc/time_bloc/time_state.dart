import 'package:islom/models/time_model.dart';

abstract class PrayerTimeState {}

class PrayerTimeInitial extends PrayerTimeState {}

class PrayerTimeLoading extends PrayerTimeState {}

class PrayerTimeLoaded extends PrayerTimeState {
  final TimeModel prayerTime;

  PrayerTimeLoaded(this.prayerTime);
}

class PrayerTimeError extends PrayerTimeState {
  final String message;

  PrayerTimeError(this.message);
}