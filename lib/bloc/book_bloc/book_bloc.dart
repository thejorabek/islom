import 'package:bloc/bloc.dart';
import 'package:islom/models/book_model.dart';
import 'book_event.dart';
import 'book_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookBloc extends Bloc<BookEvent, BookState> {
  BookBloc() : super(HadithInitial()) {
    on<LoadBookEvent>(_onLoadHadith);
  }

  Future<void> _onLoadHadith(LoadBookEvent event, Emitter<BookState> emit) async {
    String apiKey = "\$2y\$10\$h291YW7aSe2d6a3O0Lu8uoomcoTNX1kL2mcQoFNoqmXOIkQ7dm";
    emit(HadithLoading());
    try {
      // Replace this URL with your actual API endpoint
      final response = await http.get(Uri.parse("https://hadithapi.com/api/books?apiKey=$apiKey"));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final hadith = BookModel.fromJson(jsonData);
        emit(HadithLoaded(hadith));
      } else {
        emit(HadithError("Failed to load data. HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      emit(HadithError("An error occurred: $e"));
    }
  }
}
