import 'package:equatable/equatable.dart';

abstract class SurahEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSurahListEvent extends SurahEvent {}