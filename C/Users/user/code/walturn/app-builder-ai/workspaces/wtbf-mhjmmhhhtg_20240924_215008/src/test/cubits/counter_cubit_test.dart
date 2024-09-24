
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.counterapp/cubits/counter_cubit.dart';

class MockCounterCubit extends MockCubit<CounterState> implements CounterCubit {}

void main() {
	group('CounterCubit', () {
		late CounterCubit counterCubit;

		setUp(() {
			counterCubit = CounterCubit();
		});

		tearDown(() {
			counterCubit.close();
		});

		test('initial state is CounterState with value 1', () {
			expect(counterCubit.state, CounterState(1));
		});

		blocTest<CounterCubit, CounterState>(
			'emits [CounterState] with value multiplied by 10 when multiplyCounter is called',
			build: () => counterCubit,
			act: (cubit) => cubit.multiplyCounter(),
			expect: () => [CounterState(10)],
		);
	});
}
