import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:posmpi_kotlin/pages/configuration/configuration_controller.dart';
import 'package:posmpi_kotlin/pages/controllers/companies_controller.dart';
import 'package:posmpi_kotlin/pages/home/home_page.dart';
import 'package:posmpi_kotlin/pages/login/login_controller.dart';
import 'package:posmpi_kotlin/pages/login/login_page.dart';
import 'package:cron/cron.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final CompaniesController companiesController =
        Get.put(CompaniesController());
    final LoginController loginController = Get.put(LoginController());
    final ConfigurationController configurationController =
        Get.put(ConfigurationController());

    final cron = Cron();

    cron.schedule(Schedule.parse('*/3 * * * *'), () async {
     await loginController.login( loginController.usuario.text,
          loginController.senha.text);
     print(companiesController.token);
    });


    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
