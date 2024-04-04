import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage2(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyHomePage2 extends StatelessWidget {
  final String title;

  const MyHomePage2({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnotherController>(
        init: AnotherController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: Column(
              children: [
                Center(child: Text('${controller.counterValue()}')),
                ElevatedButton(
                    onPressed: () => {Get.to(() => NewPage())},
                    child: const Text('Open New page'))
              ],
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                controller.increment();
              },
            ),
          );
        });
  }
}

class NewPage extends StatelessWidget {
  const NewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnotherController>(
      init: Get.find<AnotherController>(),
      builder: (controller) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.increment();
            },
          ),
          body: Center(
            child: Text('${controller.counterValue()}'),
          ),
        );
      }
    );
  }
}


class Controller extends GetxController {
  Data data = Data();

  Controller() : data = Data();

  counterValue() => data.counter;

  increment() => data.counter.value++;
}

class MyController extends GetxController {
  final data = MyData().obs;

  counterValue() => data.value.counter;

  increment() => data.update((val) {
        val?.counter++;
      });

  @override
  void onInit() {
    super.onInit();
    print("onInit");
  }

  @override
  void onReady() {
    print("onReady");
    ever(data, (it) {
      print("Data changed ${data.value.counter}");
    });
  }

  @override
  void onClose() {
    print("onClose");
  }
}

class AnotherController extends GetxController {
  AnotherData data = AnotherData();

  void increment() {
    data.counter++;
    update();
  }

  int counterValue() => data.counter;
}
