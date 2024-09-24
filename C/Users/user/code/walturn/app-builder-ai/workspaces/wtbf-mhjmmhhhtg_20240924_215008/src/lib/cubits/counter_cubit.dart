
import 'package:flutter_bloc/flutter_bloc.dart';

// CounterState class definition
class CounterState {
	final int value;

	CounterState(this.value);
}

// CounterCubit class definition
class CounterCubit extends Cubit<CounterState> {
	CounterCubit() : super(CounterState(1));

	void multiplyCounter() {
		final newValue = state.value * 10;
		emit(CounterState(newValue));
	}
}
