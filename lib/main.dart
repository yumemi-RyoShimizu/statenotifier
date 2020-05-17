import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';
import 'package:provider/provider.dart';

part 'main.freezed.dart';

@freezed
abstract class CountState with _$CountState {
  const factory CountState({
    @Default(0) int count,
  }) = _CountState;
}

class CounterController extends StateNotifier<CountState> {
  CounterController() : super(const CountState());

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: StateNotifierProvider<CounterController, CountState>(
      create: (_) => CounterController(),
      child: HomePage(),
    ));
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              context.select<CountState, String>((s) => s.count.toString()),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CounterController>().increment(),
        child: Icon(Icons.add),
      ),
    );
  }
}
