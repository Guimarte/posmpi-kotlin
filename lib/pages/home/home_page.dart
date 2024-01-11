import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:posmpi_kotlin/models/payments.dart';
import 'package:posmpi_kotlin/pages/configuration/configuration_controller.dart';
import 'package:posmpi_kotlin/pages/configuration/configuration_page.dart';
import 'package:posmpi_kotlin/pages/controllers/companies_controller.dart';
import 'package:posmpi_kotlin/pages/login/login_controller.dart';
import 'package:posmpi_kotlin/requesters/requesters.dart';
import 'package:posmpi_kotlin/widgets/botao_widget.dart';
import 'package:posmpi_kotlin/widgets/card_pagamento_widget.dart';

import '../../pos/vero/vero.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  ConfigurationController configurationController =
      Get.put(ConfigurationController());
  CompaniesController companiesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,centerTitle: true,
            title: Image.asset(
              "lib/assets/logo/logo.png",
              width: 110,
              height: 90,
            ),
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(ConfigurationPage());
                },
                icon: Icon(Icons.settings, color: Colors.white,),
              ),
            ]),
        body: Container(
          color: Color(0xff202421),
          child: Column(children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.03,
            ),
            Expanded(
              flex: 11,
              child: Obx(() {
                if (companiesController.payments.isEmpty &&
                    companiesController.isLoading.value == true) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.orange,
                    ),
                  );
                }
                if (companiesController.payments.isEmpty) {
                  return const Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Nenhuma venda, clique no botão abaixo para buscar vendas pendentes", textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontSize: 20),),
                        ),
                        Icon(Icons.arrow_downward_outlined, color: Colors.orange,size: 48,)
                      ],
                    ),
                  );
                } else {
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,childAspectRatio: 2),
                    itemCount: companiesController.payments.value.length,
                    itemBuilder: (context, index) {
                      String transacao = "";
                      switch (
                          companiesController.payments[index].paymentMethod) {
                        case "CartaoCredito":
                          transacao = "Cartão Crédito";
                          break;
                        case "CartaoDebito":
                          transacao = "Cartão Débito";
                          break;
                        case "PagamentoInstantaneoPIX":
                          transacao = "PIX";
                          break;
                        default:
                          transacao = "Meio de pagamento Inválido";
                      }
                      return CardPagamentoWidget(
                          image: _getIconForTransaction(transacao),
                          tipoPagamento: transacao,
                          valor: companiesController.payments[index].price
                              .toStringAsFixed(2),
                          function: () async {
                            String transacaoCartao = "";
                            switch (companiesController
                                .payments[index].paymentMethod) {
                              case "CartaoCredito":
                                transacaoCartao = "CREDITO";
                                break;
                              case "CartaoDebito":
                                transacaoCartao = "DEBITO";
                                break;
                              case "PagamentoInstantaneoPIX":
                                transacaoCartao = "PIX";
                                break;
                            }
                            bool? finalizarVenda = await Vero.transacionar(
                                (companiesController.payments[index].price *
                                        100)
                                    .toInt(),
                                configurationController.imprime.value,
                                transacaoCartao,
                                companiesController
                                    .payments[index].transactionId);
                            if (finalizarVenda!) {
                              companiesController.buscaVendas(
                                  companiesController.token.value,
                                  configurationController.id.value);
                            }
                          });
                    },
                  );
                }
              }),
            ),
            Expanded(
                flex: 2,
                child: BotaoPrincipal(
                    function: () async {
                      companiesController.buscaVendas(
                          companiesController.token.value,
                          configurationController.id.value);

                      companiesController.payments.value.forEach((element) {
                        print(element.paymentMethod);
                      });
                    },
                    nome: "Atualizar vendas")),
            SizedBox()
          ]),
        ),
      ),
    );
  }

  SvgPicture _getIconForTransaction(String paymentMethod) {
    switch (paymentMethod) {
      case "Cartão Crédito":
        return SvgPicture.asset(
          "lib/assets/logo/CRED.svg",

        );
      case "Cartão Débito":
        return SvgPicture.asset(
          'lib/assets/logo/DEB.svg',

        );
      case "PIX":
        return SvgPicture.asset(
          'lib/assets/logo/PIX.svg',

        );
      default:
        return SvgPicture.asset(
          'lib/assets/logo/CRED.svg',

        );
    }
  }
}
