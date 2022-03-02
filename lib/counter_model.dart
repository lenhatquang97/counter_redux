class CounterModel {
  final int value;
  final CounterState state;
  CounterModel({required this.value, required this.state});
  factory CounterModel.initial() =>
      CounterModel(value: 0, state: CounterState.none);
}

enum CounterState { none, increment, decrement }

CounterModel counterReducer(CounterModel prev, action) {
  if (action == CounterState.increment) {
    return CounterModel(value: prev.value + 1, state: CounterState.increment);
  }
  if (action == CounterState.decrement) {
    return CounterModel(value: prev.value - 1, state: CounterState.decrement);
  }
  return prev;
}
