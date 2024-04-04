import 'package:get/get.dart';

class Data {
  final counter = Rx<int>(0);

  Data();
}

class MyData {
  int counter;

  MyData({
    this.counter = 0,
  });
}

class AnotherData {
  int counter = 0;
}
