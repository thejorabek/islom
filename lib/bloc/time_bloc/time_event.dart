abstract class PrayerTimeEvent {}

class LoadPrayerTimeEvent extends PrayerTimeEvent {
  final String address;
  final String date;

  LoadPrayerTimeEvent({required this.address, required this.date});
}