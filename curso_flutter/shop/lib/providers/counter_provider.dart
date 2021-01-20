import 'package:flutter/widgets.dart';

class CounterState {
  int _value = 1;

  int inc() => ++_value;
  int dec() => ++_value;

  int get value => _value;

  bool diff(CounterState old) {
    return old == null || old._value != this._value;
  }
}

class CounterProvider extends InheritedWidget {
  final CounterState state = CounterState();

  CounterProvider({Widget child}) : super(child: child);

  static CounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
