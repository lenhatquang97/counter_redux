import 'package:counter_redux/counter_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Store<CounterModel> store = Store<CounterModel>(counterReducer,
        initialState: CounterModel.initial());
    return StoreProvider<CounterModel>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(
          title: 'Flutter Demo Home Page',
          store: store,
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title, required this.store})
      : super(key: key);
  final String title;
  final Store<CounterModel> store;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StoreConnector<CounterModel, String>(
              converter: (store) => store.state.value.toString(),
              builder: (context, vm) => Text(
                vm,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StoreConnector<CounterModel, VoidCallback>(
              converter: (store) {
                return () => store.dispatch(CounterState.decrement);
              },
              builder: (context, callback) {
                return FloatingActionButton(
                  onPressed: callback,
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                );
              },
            ),
            StoreConnector<CounterModel, VoidCallback>(
              converter: (store) {
                return () => store.dispatch(CounterState.increment);
              },
              builder: (context, callback) {
                return FloatingActionButton(
                  onPressed: callback,
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
