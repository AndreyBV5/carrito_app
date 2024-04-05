import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Contador con GetX',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final CountController _controller = Get.put(CountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contador con GetX'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GetBuilder<CountController>(
              builder: (_) => Text(
                'Contador: ${_.count}',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _controller.increment();
                  },
                  child: Icon(Icons.add),
                ),
                SizedBox(width: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _controller.decrement();
                  },
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CountController extends GetxController {
  var count = 0.obs;

  void increment() {
    count++;
  }

  void decrement() {
    count--;
  }
}
