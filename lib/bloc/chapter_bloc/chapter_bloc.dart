import 'package:bloc/bloc.dart';
import 'package:islom/models/chapter_mode.dart';
import 'chapter_event.dart';
import 'chapter_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChapterBloc extends Bloc<ChapterEvent, ChapterState> {
  ChapterBloc() : super(ChapterInitial()) {
    on<LoadChaptersEvent>(_onLoadChapters);
  }

  Future<void> _onLoadChapters(LoadChaptersEvent event, Emitter<ChapterState> emit) async {
    emit(ChapterLoading());
    try {
      final url = "https://hadithapi.com/api/${event.bookSlug}/chapters?apiKey=\$2y\$10\$h291YW7aSe2d6a3O0Lu8uoomcoTNX1kL2mcQoFNoqmXOIkQ7dm";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final chapterModel = ChapterModel.fromJson(jsonData);
        emit(ChapterLoaded(chapterModel));
      } else {
        emit(ChapterError("Failed to load chapters. HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      emit(ChapterError("An error occurred: $e"));
    }
  }
}