import 'package:equatable/equatable.dart';
import 'package:islom/models/chapter_model.dart';

abstract class ChapterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChapterInitial extends ChapterState {}

class ChapterLoading extends ChapterState {}

class ChapterLoaded extends ChapterState {
  final ChapterModel chapterModel;

  ChapterLoaded(this.chapterModel);

  @override
  List<Object?> get props => [chapterModel];
}

class ChapterError extends ChapterState {
  final String message;

  ChapterError(this.message);

  @override
  List<Object?> get props => [message];
}