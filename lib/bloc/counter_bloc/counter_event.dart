import 'package:equatable/equatable.dart';

abstract class CountdownEvent extends Equatable {
  const CountdownEvent();

  @override
  List<Object> get props => [];
}

class DecrementCountdown extends CountdownEvent {}