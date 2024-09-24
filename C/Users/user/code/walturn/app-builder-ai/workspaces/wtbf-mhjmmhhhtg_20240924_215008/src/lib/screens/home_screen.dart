
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:counterapp/cubits/counter_cubit.dart';
import 'package:counterapp/models/counter_state.dart';

class HomeScreen extends StatelessWidget {
	const HomeScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('Counter App'),
			),
			body: Center(
				child: BlocBuilder<CounterCubit, CounterState>(
					builder: (context, state) {
						return Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								Text(
									'Current Value: ${state.value}',
									style: Theme.of(context).textTheme.headline4,
								),
								const SizedBox(height: 20),
								ElevatedButton(
									onPressed: () {
										context.read<CounterCubit>().multiplyCounter();
									},
									child: const Text('Multiply by 10'),
								),
							],
						);
					},
				),
			),
		);
	}
}
