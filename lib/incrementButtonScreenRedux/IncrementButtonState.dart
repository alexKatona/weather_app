import 'package:flutter/material.dart';

@immutable
class IncrementButtonState {
  final int counter;
  final double counterSize;

  IncrementButtonState(this.counter, this.counterSize);

  factory IncrementButtonState.initial() => IncrementButtonState(0, 20.0);

  IncrementButtonState copyWith({int counter, double counterSize}) {
    return IncrementButtonState(counter ?? this.counter, counterSize ?? this.counterSize);
  }
}
