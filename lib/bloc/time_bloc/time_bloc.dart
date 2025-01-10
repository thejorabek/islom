import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:islom/bloc/time_bloc/time_event.dart';
import 'package:islom/bloc/time_bloc/time_state.dart';
import 'package:islom/models/time_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class PrayerTimeBloc extends Bloc<PrayerTimeEvent, PrayerTimeState> {
  PrayerTimeBloc() : super(PrayerTimeInitial()) {
    on<LoadPrayerTimeEvent>(_onLoadPrayerTime);
  }

  Future<String> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return 'Tashkent,UZB'; // Default location
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return 'Tashkent,UZB';
      }
    }

    Position position = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return '${place.locality},${place.isoCountryCode}';
    }
    return 'Tashkent,UZB';
  }

  String _getCurrentDate() {
    final now = DateTime.now();
    return '${now.day.toString().padLeft(2, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.year}';
  }

  Future<void> _onLoadPrayerTime(LoadPrayerTimeEvent event, Emitter<PrayerTimeState> emit) async {
    emit(PrayerTimeLoading());

    try {
      final location = await _getCurrentLocation();
      final date = _getCurrentDate();
      print(date);
      print(location);
      final url = "https://api.aladhan.com/v1/timingsByAddress/$date?address=$location&method=6";

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final prayerTime = TimeModel.fromJson(data);
        emit(PrayerTimeLoaded(prayerTime));
      } else {
        emit(PrayerTimeError("Failed to load prayer times."));
      }
    } catch (e) {
      emit(PrayerTimeError("An error occurred: $e"));
    }
  }
}
