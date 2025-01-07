import 'package:equatable/equatable.dart';
import 'package:islom/models/hadith_model.dart';

abstract class HadithState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HadithInitial extends HadithState {}

class HadithLoading extends HadithState {}

class HadithLoaded extends HadithState {
  final HadithModel hadith;

  HadithLoaded(this.hadith);

  @override
  List<Object?> get props => [hadith];
}

class HadithError extends HadithState {
  final String message;

  HadithError(this.message);

  @override
  List<Object?> get props => [message];
}