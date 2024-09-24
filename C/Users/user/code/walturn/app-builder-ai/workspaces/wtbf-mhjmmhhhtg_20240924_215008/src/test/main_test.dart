
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:counterapp/main.dart';

class MockCounterCubit extends MockCubit<int> implements CounterCubit {}

void main() {
	group('MyApp', () {
		testWidgets('renders MyApp with HomeScreen', (tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});

	group('CounterCubit', () {
		late CounterCubit counterCubit;

		setUp(() {
			counterCubit = CounterCubit();
		});

		blocTest<CounterCubit, int>(
			'emits [0, 10] when multiplyCounter is called',
			build: () => counterCubit,
			act: (cubit) => cubit.multiplyCounter(),
			expect: () => [0, 10],
		);
	});

	group('HomeScreen', () {
		late CounterCubit mockCounterCubit;

		setUp(() {
			mockCounterCubit = MockCounterCubit();
			when(() => mockCounterCubit.state).thenReturn(0);
		});

		testWidgets('displays initial counter value', (tester) async {
			await tester.pumpWidget(
				BlocProvider<CounterCubit>.value(
					value: mockCounterCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);
			expect(find.text('0'), findsOneWidget);
		});

		testWidgets('calls multiplyCounter when button is pressed', (tester) async {
			await tester.pumpWidget(
				BlocProvider<CounterCubit>.value(
					value: mockCounterCubit,
					child: MaterialApp(home: HomeScreen()),
				),
			);

			await tester.tap(find.byType(ElevatedButton));
			verify(() => mockCounterCubit.multiplyCounter()).called(1);
		});
	});
}
