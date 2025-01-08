import 'package:equatable/equatable.dart';
import 'package:islom/models/book_model.dart';

abstract class BookState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HadithInitial extends BookState {}

class HadithLoading extends BookState {}

class HadithLoaded extends BookState {
  final BookModel hadith;

  HadithLoaded(this.hadith);

  @override
  List<Object?> get props => [hadith];
}

class HadithError extends BookState {
  final String message;

  HadithError(this.message);

  @override
  List<Object?> get props => [message];
}
