import 'package:equatable/equatable.dart';

abstract class ChapterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadChaptersEvent extends ChapterEvent {
  final String bookSlug;

  LoadChaptersEvent(this.bookSlug);

  @override
  List<Object?> get props => [bookSlug];
}