import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:posmpi_kotlin/models/companies.dart';
import 'package:posmpi_kotlin/pages/configuration/configuration_controller.dart';
import 'package:posmpi_kotlin/pages/controllers/companies_controller.dart';
import 'package:posmpi_kotlin/pages/home/home_page.dart';
import 'package:posmpi_kotlin/widgets/botao_widget.dart';
import 'package:posmpi_kotlin/widgets/input_configuration.dart';

class ConfigurationPage extends StatelessWidget {
  ConfigurationPage({super.key});

  ConfigurationController configurationController =
      Get.put(ConfigurationController());
  CompaniesController companiesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar( leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
          iconTheme: IconThemeData(
            color: Colors.white, // Defina a cor desejada para o ícone
          ),
          backgroundColor: Colors.black,centerTitle: true,
          title: Text("Configurações",style: TextStyle(color: Colors.white),),
        ),
        body: Container(
          height: MediaQuery.sizeOf(context).height * 1,
          color: Color(0xff202421),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Imprime o comprovante de venda?",
                      style: TextStyle(color: Colors.white),
                    ),
                    Obx(() => Checkbox(
                        side: BorderSide(color: Colors.white),
                        activeColor: Color(0xFFFF6600),
                        value: configurationController.imprime.value,
                        onChanged: (value) {
                          configurationController.imprimeComprovante(value!);
                          configurationController.setImprime();
                        })),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child:
                    Text("Selecione a sua empresa:", textAlign: TextAlign.left,style: TextStyle(color: Colors.white),),
              ),
              Container(
                height: MediaQuery.sizeOf(context).height * 0.5,
                child: ListView.builder(
                    itemCount: companiesController.companies?.value.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          companiesController.companieSelected =
                              companiesController.companies![index];
                          print(
                              companiesController.companieSelected.fantasyName);
                          companiesController.isSelected.value = true;
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: Obx(() => Card(
                              color: companiesController.isSelected.value
                                  ? Colors.green
                                  : Colors.grey,
                              child: Center(
                                child: Text(
                                  "${companiesController.companies![index].fantasyName!} ${companiesController.companies![index].cnpj!}",
                                  textAlign: TextAlign.center,
                                ),
                              ))),
                        ),
                      );
                    }),
              ),
              Center(
                child: BotaoPrincipal(
                    nome: "Salvar Configurações",
                    function: () {
                      if (companiesController.companieSelected.id != null) {
                        configurationController.saveData(
                          id: companiesController.companieSelected.id!,
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => HomePage()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "Selecione uma loja para salvar as configurações",
                            )));
                      }
                    }),
              ),
            ],
          ),
        ),

      ),
    );
  }
}
