// ignore_for_file: deprecated_member_use

import 'package:counter_app/controller/list%20model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CounterController extends GetxController {
  var counterList = <CounterListMode>[].obs;

  TextEditingController titleController = TextEditingController();

  var counter = 0.obs;
  var add = 1.obs;
  var getindex = (-1).obs;
  TextEditingController addController = TextEditingController();

  Future<void> increaseCounter() async {
    try {
      add.value = int.tryParse(addController.text) ?? 0;
      counter.value = counter.value + add.value;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> decreaseCounter() async {
    try {
      add.value = int.tryParse(addController.text) ?? 0;
      counter.value = counter.value - add.value;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getCounter(int index) async {
    try {
      titleController.text = counterList[index].name;
      counter.value = counterList[index].count;
      getindex.value = index;
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> savedCounter(BuildContext context) async {
    try {
      if (getindex.value != -1) {
        counterList[getindex.value] = CounterListMode(
          count: counter.value.isNull ? 0 : counter.value,
          name: titleController.text.isEmpty
              ? "Title ${counterList.length}"
              : titleController.text,
        );
      } else {
        counterList.add(
          CounterListMode(
            count: counter.value.isNull ? 0 : counter.value,
            name: titleController.text.isEmpty
                ? "Title ${counterList.length}"
                : titleController.text,
          ),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('counter saved'),
        ),
      );
      counter.value = 0;
      titleController.clear();
      add.value = 1;
      addController.text = add.value.toString();
      getindex.value = -1;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteCounter(int index) async {
    try {
      counterList.removeAt(index);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> setCounterList() async {
    try {
      ever(counterList, (_) {
        GetStorage().write('list', counterList.toList());
        debugPrint("Strategy saved ${counterList.length}");
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getCounterList() async {
    try {
      List? sotredList = GetStorage().read<List>('list');
      if (!sotredList.isNull) {
        counterList.value =
            sotredList!.map((e) => CounterListMode.fromJson(e)).toList();
      }
      debugPrint("Get saved strategy ${counterList.length}");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final BannerAd counterBanner = BannerAd(
    adUnitId: BannerAd.testAdUnitId,
    size: const AdSize(width: 300, height: 250),
    request: const AdRequest(),
    listener: const BannerAdListener(),
  );

  @override
  void onInit() {
    counterBanner.dispose();
    counterBanner.load();

    addController.text = add.value.toString();

    setCounterList();
    getCounterList();

    super.onInit();
  }
}
