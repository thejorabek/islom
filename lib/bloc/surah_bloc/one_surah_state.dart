import 'package:equatable/equatable.dart';
import 'package:islom/models/one_surah_model.dart';

abstract class OneSurahState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OneSurahInitial extends OneSurahState {}

class OneSurahLoading extends OneSurahState {}

class OneSurahLoaded extends OneSurahState {
  final GetOneSurahModel surah;

  OneSurahLoaded(this.surah);

  @override
  List<Object?> get props => [surah];
}

class OneSurahError extends OneSurahState {
  final String message;

  OneSurahError(this.message);

  @override
  List<Object?> get props => [message];
}