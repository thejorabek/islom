import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:islom/bloc/time_bloc/time_event.dart';
import 'package:islom/bloc/time_bloc/time_state.dart';
import 'package:islom/models/time_model.dart';

class PrayerTimeBloc extends Bloc<PrayerTimeEvent, PrayerTimeState> {
  PrayerTimeBloc() : super(PrayerTimeInitial()) {
    on<LoadPrayerTimeEvent>(_onLoadPrayerTime);
  }

  Future<void> _onLoadPrayerTime(LoadPrayerTimeEvent event, Emitter<PrayerTimeState> emit) async {
    emit(PrayerTimeLoading());

    final url = "https://api.aladhan.com/v1/timingsByAddress/08-01-2025?address=Tashkent,UZB&method=6";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final prayerTime = TimeModel.fromJson(data);
        print(prayerTime);
        emit(PrayerTimeLoaded(prayerTime));
      } else {
        emit(PrayerTimeError("Failed to load prayer times."));
      }
    } catch (e) {
      emit(PrayerTimeError("An error occurred: $e"));
    }
  }
}
