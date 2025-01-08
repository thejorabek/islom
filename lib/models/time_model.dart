class TimeModel {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String readableDate;

  TimeModel({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.readableDate,
  });

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      fajr: json['data']['timings']['Fajr'],
      sunrise: json['data']['timings']['Sunrise'],
      dhuhr: json['data']['timings']['Dhuhr'],
      asr: json['data']['timings']['Asr'],
      maghrib: json['data']['timings']['Maghrib'],
      isha: json['data']['timings']['Isha'],
      readableDate: json['data']['date']['readable'],
    );
  }
}