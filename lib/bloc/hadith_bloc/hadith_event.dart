import 'package:equatable/equatable.dart';

abstract class HadithEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadHadithEvent extends HadithEvent {}