import 'package:bloc/bloc.dart';
import 'package:islom/models/quran_model.dart';
import 'quran_event.dart';
import 'quran_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  SurahBloc() : super(SurahInitial()) {
    on<LoadSurahListEvent>(_onLoadSurahList);
  }

  Future<void> _onLoadSurahList(LoadSurahListEvent event, Emitter<SurahState> emit) async {
    emit(SurahLoading());
    try {
      // Replace with the actual API endpoint
      final response = await http.get(
        Uri.parse("https://api.alquran.cloud/v1/surah"),
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final surahList = AllSurahListModel.fromJson(jsonData);
        emit(SurahLoaded(surahList));
      } else {
        emit(SurahError("Failed to load Surah list. HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      emit(SurahError("An error occurred: $e"));
    }
  }
}
