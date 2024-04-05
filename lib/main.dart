import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class CounterController extends GetxController {
  var count = 0.obs;

  void increment() {
    count++; // Incrementa el contador
  }
}

class MyApp extends StatelessWidget {
  final CounterController _controller = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Contador con GetX'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text(
                'Contador: ${_controller.count}',
                style: TextStyle(fontSize: 24),
              )),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _controller.increment(); // Incrementa el contador
                },
                child: Text('Incrementar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}