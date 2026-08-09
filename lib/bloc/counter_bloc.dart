import 'package:flutter_bloc/flutter_bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(counter: 0)) {
    on<Increment>((event, emit) {
      if (state.counter < 100) {
        emit(CounterState(counter: state.counter + 1));
      }
    });

    on<Decrement>((event, emit) {
      if (state.counter > 0) {
        emit(CounterState(counter: state.counter - 1));
      }
    });

    on<Reset>((event, emit) {
      emit(CounterState(counter: 0, isReset: true));
    });
  }
}
