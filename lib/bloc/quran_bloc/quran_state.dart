import 'package:equatable/equatable.dart';
import 'package:islom/models/quran_model.dart';

abstract class SurahState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SurahInitial extends SurahState {}

class SurahLoading extends SurahState {}

class SurahLoaded extends SurahState {
  final AllSurahListModel surahList;

  SurahLoaded(this.surahList);

  @override
  List<Object?> get props => [surahList];
}

class SurahError extends SurahState {
  final String message;

  SurahError(this.message);

  @override
  List<Object?> get props => [message];
}
