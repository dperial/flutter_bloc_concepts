import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/constants/enums.dart';
import 'package:flutter_bloc_concepts/logic/cubit/counter_cubit.dart';
import 'package:flutter_bloc_concepts/logic/cubit/internet_cubit.dart';
import 'package:flutter_bloc_concepts/presentation/screens/second_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext homeScreenContext) {
    // context == homeScreenContext
    return BlocListener<InternetCubit, InternetState>(
      listener: (internetCubitListenerContext, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          // context.bloc<CounterCubit>().increment();
          BlocProvider.of<CounterCubit>(internetCubitListenerContext)
              .increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          BlocProvider.of<CounterCubit>(internetCubitListenerContext)
              .decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (internetCubitBuilderContext, state) {
                  if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Wifi) {
                    return Text(
                      'Wi-Fi',
                      style: Theme.of(internetCubitBuilderContext)
                          .textTheme
                          .headline3
                          ?.copyWith(
                            color: Colors.green,
                          ),
                    );
                  } else if (state is InternetConnected &&
                      state.connectionType == ConnectionType.Mobile) {
                    return Text(
                      'Mobile',
                      style: Theme.of(internetCubitBuilderContext)
                          .textTheme
                          .headline3!
                          .copyWith(
                            color: Colors.red,
                          ),
                    );
                  } else if (state is InternetDisconnected) {
                    return Text(
                      'Disconnected',
                      style: Theme.of(internetCubitBuilderContext)
                          .textTheme
                          .headline3
                          ?.copyWith(
                            color: Colors.grey,
                          ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const Divider(
                height: 5,
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
                builder: (counterCubiBuilderContext, state) {
                  if (state.counterValue! < 0) {
                    return Text(
                      'Negative Value ' + state.counterValue.toString(),
                      style: Theme.of(counterCubiBuilderContext).textTheme.headline4,
                    );
                  }else if (state.counterValue! % 2 == 0) {
                    return Text(
                      'Pair Value ' + state.counterValue.toString(),
                      style: Theme.of(counterCubiBuilderContext).textTheme.headline4,
                    );
                  }else if (state.counterValue! > 10) {
                    return Text(
                      'Sup 10 ' + state.counterValue.toString(),
                      style: Theme.of(counterCubiBuilderContext).textTheme.headline4,
                    );
                  } else {
                    return Text(
                      state.counterValue.toString(),
                      style: Theme.of(counterCubiBuilderContext).textTheme.headline4,
                    );
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),

              Builder(
                builder: (context) {
                  final counterState = context.watch<CounterCubit>().state;
                  final internetState = context.watch<InternetCubit>().state;

                  if (internetState is InternetConnected &&
                      internetState.connectionType == ConnectionType.Mobile) {
                    return Text(
                      'Counter: ' +
                          counterState.counterValue.toString() +
                          ' Internet: Mobile',
                      style: Theme.of(context).textTheme.headline6,
                    );
                  } else if (internetState is InternetConnected &&
                      internetState.connectionType == ConnectionType.Wifi) {
                    return Text(
                      'Counter: ' +
                          counterState.counterValue.toString() +
                          ' Internet: Wifi',
                      style: Theme.of(context).textTheme.headline6,
                    );
                  } else {
                    return Text(
                      'Counter: ' +
                          counterState.counterValue.toString() +
                          ' Internet: Disconnected',
                      style: Theme.of(context).textTheme.headline6,
                    );
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Builder(
                builder: (context) {
                  final counterValue = context.select((CounterCubit cubit) => cubit.state.counterValue);
                  return Text(
                    'Counter: ' + counterValue.toString(),
                    style: Theme.of(context).textTheme.headline6,
                  );
                },
              ),
              const SizedBox(
                height: 24,
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    heroTag: Text(widget.title),
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                      // context.bloc<CounterCubit>().decrement();
                    },
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    heroTag: Text('${widget.title} 2nd'),
                    onPressed: () {
                      // BlocProvider.of<CounterCubit>(context).increment();
                      context.read<CounterCubit>().increment();
                    },
                    tooltip: 'Increment',
                    child: const Icon(Icons.add),
                  ),
                ],
              ),*/
              const SizedBox(
                height: 24,
              ),
              Builder(builder: (materialButtonContext) {
                return MaterialButton(
                    color: Colors.redAccent,
                    child: const Text(
                      ' Go to Second Screen',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.of(materialButtonContext).pushNamed('/second');
                    });
              }),
              MaterialButton(
                  color: Colors.purpleAccent,
                  child: const Text(
                    ' Go to Third Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(homeScreenContext).pushNamed('/third');
                  })
            ],
          ),
        ),
      ),
    );
  }
}
