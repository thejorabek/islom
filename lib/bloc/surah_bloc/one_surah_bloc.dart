import 'package:bloc/bloc.dart';
import 'package:islom/models/one_surah_model.dart';
import 'one_surah_event.dart';
import 'one_surah_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OneSurahBloc extends Bloc<OneSurahEvent, OneSurahState> {
  OneSurahBloc() : super(OneSurahInitial()) {
    on<LoadOneSurahEvent>((event, emit) async {
      emit(OneSurahLoading());
      try {
        final response = await http.get(
          Uri.parse("https://api.alquran.cloud/v1/surah/${event.surahNumber}"),
        );
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          // Add debug print
          print('Surah ${event.surahNumber} Response: $jsonData');
          try {
            final surah = GetOneSurahModel.fromJson(jsonData);
            emit(OneSurahLoaded(surah));
          } catch (parseError) {
            print('Parse Error: $parseError');
            emit(OneSurahError('Error parsing surah data: $parseError'));
          }
        } else {
          emit(OneSurahError('Failed to load surah'));
        }
      } catch (e) {
        emit(OneSurahError('An error occurred: $e'));
      }
    });
  }
}