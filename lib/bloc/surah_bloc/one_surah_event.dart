import 'package:equatable/equatable.dart';

abstract class OneSurahEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadOneSurahEvent extends OneSurahEvent {
  final int surahNumber;

  LoadOneSurahEvent(this.surahNumber);

  @override
  List<Object?> get props => [surahNumber];
}