import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/logic/cubit/counter_cubit.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: const Text('Third Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            const SizedBox(
              height: 40,
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incremented'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Decremented'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.counterValue! < 0) {
                  return Text(
                    'Negative Value ' + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
                if (state.counterValue! % 2 == 0) {
                  return Text(
                    'Pair Value ' + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
                if (state.counterValue! > 10) {
                  return Text(
                    'Sup 10 ' + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: widget.color,
                  onPressed: () {
                    // context.bloc<CounterCubit>().decrement();
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  backgroundColor: widget.color,
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
