// ignore_for_file: must_be_immutable, camel_case_types

import 'package:counter_app/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterController controller = Get.put(CounterController());
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          top: 32,
          right: 10,
          bottom: 10,
        ),
        child: Column(
          children: <Widget>[
            const Text("Saved Counter List"),
            const Divider(
              height: 24,
              color: Colors.grey,
              thickness: 2,
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) =>
                    DrawerPage_ListDetail(index: index),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: controller.counterList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerPage_ListDetail extends StatelessWidget {
  int index;
  DrawerPage_ListDetail({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CounterController controller = Get.find();
    return Obx(
      () => (controller.counterList.isNotEmpty)
          ? ListTile(
              onTap: () => controller.getCounter(index),
              leading: Text("#${(index + 1).toString()}"),
              title: Text(controller.counterList[index].name.toUpperCase()),
              subtitle:
                  Text("Total count: ${controller.counterList[index].count}"),
              trailing: IconButton(
                onPressed: () => controller.deleteCounter(index),
                icon: const Icon(
                  Icons.delete_rounded,
                  color: Colors.grey,
                  size: 16,
                ),
              ),
            )
          : const Center(
              child: Text("List is empty"),
            ),
    );
  }
}
