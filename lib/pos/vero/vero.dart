import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posmpi_kotlin/requesters/requesters.dart';
import 'package:posmpi_kotlin/utils/utils.dart';

class Vero {
  static String? nsu;
  static String? codigoFiscal;
  static String? codTransacao;
  static String? codAutorizacao;
  static String? bandeira;
  static String? tipoTransacao;
  static const _platform = MethodChannel("vero_channel");
  static bool? sucesso;

  static Future<bool?> transacionar(
      int amount, bool imprime, String transacao, String transactionId) async {
    var result;

    try {
      result = await _platform.invokeMethod('transacionar',
          {"amount": amount, "imprime": imprime, "transacao": transacao});
      print(result);
      sucesso = true;
      if (result["nsu"] == null) {
        return sucesso = false;
      } else {
        sucesso = true;

        double pagamento = double.parse(result["valor"]) / 100;

        print(pagamento);
        String formaPagamento = "";
        switch (result["transacao"]) {
          case "Débito a Vista":
            formaPagamento = "CartaoDebito";
            break;
          case "Crédito a Vista":
            formaPagamento = "CartaoCredito";
            break;
          case "PIX":
            formaPagamento = "PagamentoInstantaneoPIX";
            break;
        }
        // String bandeira = result["bandeira"];
        // if (bandeira == "BANRICOMPRAS") {
        //   bandeira = "Outros";
        // }

        String bandeira = Utils().convertBandeiraToServer(result["bandeira"]);

        var response = await Requesters().postTransaction(
            pagamento,
            bandeira,
            formaPagamento,
            result["autorizacao"],
            transactionId,
            sucesso!,
            result["adquirente"], result["comprovante"].toString());
        print(response);
        return sucesso;
      }
    } catch (e) {
      sucesso = false;
    }
    return sucesso;
  }

  static Future<bool?> reimpressao(BuildContext context) async {
    try {
      sucesso = false;
      await _platform.invokeMethod('reimprimir');
      sucesso = true;
    } catch (e, s) {
      print(s);
      Navigator.pop(context);
    }
    return sucesso;
  }

  static Future<bool?> estorno(
      BuildContext context, String amount, String transactionDate) async {
    try {
      sucesso = false;
      await _platform.invokeMethod(
          'estorno', {"amount": amount, "transactionDate": transactionDate});
      sucesso = true;
    } catch (e, s) {
      print(s);
      Navigator.pop(context);
    }
    return sucesso;
  }
}
