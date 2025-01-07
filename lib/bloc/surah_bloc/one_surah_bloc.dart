import 'package:bloc/bloc.dart';
import 'package:islom/models/one_surah_model.dart';
import 'one_surah_event.dart';
import 'one_surah_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OneSurahBloc extends Bloc<OneSurahEvent, OneSurahState> {
  OneSurahBloc() : super(OneSurahInitial()) {
    on<LoadOneSurahEvent>(_onLoadOneSurah);
  }

  Future<void> _onLoadOneSurah(
      LoadOneSurahEvent event, Emitter<OneSurahState> emit) async {
    emit(OneSurahLoading());
    try {
      // Replace with the actual API endpoint
      final response = await http.get(
        Uri.parse("https://api.alquran.cloud/v1/surah/${event.surahNumber}"),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final surah = GetOneSurahModel.fromJson(jsonData);
        emit(OneSurahLoaded(surah));
      } else {
        emit(OneSurahError("Failed to load Surah. HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      emit(OneSurahError("An error occurred: $e"));
    }
  }
}