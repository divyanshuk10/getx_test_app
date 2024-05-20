import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_app/counter_repository.dart';

void main() {
// Creating an instance of CounterRepository for dependency injection via Getx
  Get.lazyPut(() => CounterRepository());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Getx Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CounterRepository repo = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => {Get.to(() => SecondScreen())},
              child: const Text('Open New page'),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Text(
                '${repo.count.value}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: repo.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterRepository repo = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => {Get.back()},
              child: const Text('Go to previous Screen'),
            ),
            const SizedBox(height: 16),
            Obx(
              () => Text(
                '${repo.count.value}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: repo.decrement,
        child: const Icon(Icons.remove),
      ),
    );
  }
}
