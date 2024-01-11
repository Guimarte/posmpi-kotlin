import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posmpi_kotlin/pages/controllers/companies_controller.dart';
import 'package:posmpi_kotlin/requesters/requesters.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController usuario = TextEditingController();
  TextEditingController senha = TextEditingController();
  CompaniesController companiesController = Get.find();
  RxBool salvaSenha = false.obs;

  onInit() {
    super.onInit();
    getUser();
  }

  Future<bool> login(String usuario, String senha) async {
    try {
      await Requesters().getToken(usuario, senha);
      if (companiesController.token.value.isEmpty) {
        return false;
      }
      await Requesters().getCompanies(companiesController.token.value);

      return true;
    } catch (e, s) {
      return false;
    }
  }

  void funcSalvaSenha(bool value) {
    salvaSenha.value = value;
  }

  saveUser(
      {required String usuario,
      required String senha,
      required bool salvaSenha}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("salvaSenha", salvaSenha);
    await prefs.setString("usuario", usuario);
    await prefs.setString("senha", senha);
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(await prefs.getBool("salvaSenha") != null) {
      salvaSenha.value = await prefs.getBool("salvaSenha")!;
    }
    if (salvaSenha.value) {
      usuario.text = await prefs.getString("usuario")!;
      senha.text = await prefs.getString("senha")!;
    }
  }
}
