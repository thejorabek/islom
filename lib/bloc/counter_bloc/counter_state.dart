import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:islom/utils/colors/colors.dart';

class CountdownState extends Equatable {
  final int remaining;
  final Color currentColor;

  const CountdownState({required this.remaining, required this.currentColor});

  factory CountdownState.initial() {
    return CountdownState(
      remaining: 30,
      currentColor: CustomColors.tile,
    );
  }

  CountdownState copyWith({
    int? remaining,
    Color? currentColor,
  }) {
    return CountdownState(
      remaining: remaining ?? this.remaining,
      currentColor: currentColor ?? this.currentColor,
    );
  }

  @override
  List<Object> get props => [remaining, currentColor];
}