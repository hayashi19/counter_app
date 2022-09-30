import 'package:counter_app/controller/controller.dart';
import 'package:counter_app/pages/counter.dart';
import 'package:counter_app/pages/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter App"),
        centerTitle: true,
      ),
      drawer: const DrawerPage(),
      body: const CounterPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.put(CounterController()).savedCounter(context),
        child: const Icon(Icons.save_rounded),
      ),
    );
  }
}
