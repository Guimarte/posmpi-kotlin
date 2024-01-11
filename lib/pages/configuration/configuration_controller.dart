import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurationController extends GetxController {
  TextEditingController caixa = TextEditingController();
  RxString cnpjData = "".obs;
  RxBool imprime = false.obs;
  RxInt id = 0.obs;

  onInit() {
    super.onInit();
    getImprime();
  }

  saveData({required int id}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("imprime", imprime.value);
    await prefs.setInt("id", id);
  }

  Future<int> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("id") != null) {
      id.value = prefs.getInt("id")!;
    }
    return id.value;
  }

  getImprime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("imprime") != null) {
      imprime.value = prefs.getBool("imprime")!;
    }
    return imprime.value;
  }

  setImprime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("imprime", imprime.value);
  }

  imprimeComprovante(bool newValue) {
    imprime.value = newValue;
    print(imprime.value);
  }
}
