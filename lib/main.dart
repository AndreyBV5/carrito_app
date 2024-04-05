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
      title: 'App Carrito',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Carrito de Compras'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(child: _SampleCard(cardName: 'Elevated Card')),
              Card.filled(child: _SampleCard(cardName: 'Filled Card')),
              Card.outlined(child: _SampleCard(cardName: 'Outlined Card')),
            ],
          ),
        ),
      ),
    );
  }
}

class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Center(child: Text(cardName)),
    );
  }
}
