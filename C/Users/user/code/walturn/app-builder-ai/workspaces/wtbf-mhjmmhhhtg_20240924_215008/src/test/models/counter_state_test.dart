
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:counterapp/models/counter_state.dart';

void main() {
	group('CounterState', () {
		test('CounterState should initialize with the given value', () {
			final counterState = CounterState(5);
			expect(counterState.value, 5);
		});
	});
}
