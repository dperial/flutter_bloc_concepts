import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/logic/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    CounterCubit? counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit?.close();
    });

    test(
        'The initial state for the CounterCubit is CounterState(counterValue:0, wasIncremented: false',
        () {
      expect(counterCubit?.state,
          CounterState(counterValue: 0, wasIncremented: false));
    });
    blocTest<CounterCubit, CounterState>(
      'The cubit should emit a CounterState(counterValue: 1, wasIncremented: true) when cubit.incremented is called.',
      build: () => CounterCubit(),
      act: (bloc) => bloc.increment(),
      expect: () => [CounterState(counterValue: 1, wasIncremented: true)],
    );
    blocTest<CounterCubit, CounterState>(
      'The cubit should emit a CounterState(counterValue: -1, wasIncremented: false) when cubit.decremented is called.',
      build: () => CounterCubit(),
      act: (bloc) => bloc.decrement(),
      expect: () => [CounterState(counterValue: -1, wasIncremented: false)],
    );
  });
}
