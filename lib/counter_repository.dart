import 'package:get/get.dart';

class CounterRepository {
  CounterRepository();

  final Rx count = 0.obs;
  final int _value = 1;

  void increment() => count.value += _value;

  void decrement() => count.value -= _value;
}
