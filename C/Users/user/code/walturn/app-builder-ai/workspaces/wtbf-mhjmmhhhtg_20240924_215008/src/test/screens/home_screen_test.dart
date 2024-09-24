
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:counterapp/screens/home_screen.dart';
import 'package:counterapp/cubits/counter_cubit.dart';
import 'package:counterapp/models/counter_state.dart';

class MockCounterCubit extends MockCubit<CounterState> implements CounterCubit {}

void main() {
	group('HomeScreen', () {
		late CounterCubit counterCubit;

		setUp(() {
			counterCubit = MockCounterCubit();
		});

		testWidgets('renders initial state correctly', (tester) async {
			when(() => counterCubit.state).thenReturn(CounterState(1));

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: counterCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Current Value: 1'), findsOneWidget);
		});

		testWidgets('renders updated state correctly', (tester) async {
			whenListen(
				counterCubit,
				Stream.fromIterable([CounterState(10)]),
				initialState: CounterState(1),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: counterCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.pump();
			expect(find.text('Current Value: 10'), findsOneWidget);
		});

		testWidgets('triggers multiplyCounter when button is pressed', (tester) async {
			when(() => counterCubit.state).thenReturn(CounterState(1));
			when(() => counterCubit.multiplyCounter()).thenReturn(null);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: counterCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.tap(find.byType(ElevatedButton));
			verify(() => counterCubit.multiplyCounter()).called(1);
		});
	});
}
