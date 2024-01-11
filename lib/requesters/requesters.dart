import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:posmpi_kotlin/models/companies.dart';
import 'package:posmpi_kotlin/models/payments.dart';
import 'package:posmpi_kotlin/pages/configuration/configuration_controller.dart';
import 'package:posmpi_kotlin/pages/controllers/companies_controller.dart';
import 'package:posmpi_kotlin/requesters/end_points.dart';


class Requesters {
  Dio dio = Dio();

  CompaniesController companiesController = Get.find();
  ConfigurationController configurationController = Get.find();

  getToken(String usuario, String senha) async {
    try {
      Map<String, String> queryParams = {
        "grant_type": "password",
        "client_id": "mpi-client",
        "client_secret": "meMRgUp8JNrQ5tuLSJEsSdENi9HetNVY",
        "username": usuario,
        "password": senha,
      };
      var response = await dio.post(EndPoints.getToken(),
          options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'},
          ),
          data: queryParams);
      companiesController.token.value = response.data['access_token'];

    } on DioException catch (e) {
      print(e);
    }
  }

  getCompanies(String token) async {
    try {
      var responseDados = await dio.get(EndPoints.getCompanies(),
          options: Options(headers: {
            'Authorization': 'Bearer ${companiesController.token.value}'
          }));
      companiesController.companies!.value =
          Companies.listFromJson(responseDados.data['data']);

    } on DioException catch (e) {
      print(e);
    }
  }

  Future<List<Payments>> getTransaction(String token, int id) async {
    try {
      var response = await dio.get(EndPoints.getPayments(),
          queryParameters: {'companyId': id},
          options: Options(
            headers: {
              'Authorization': 'Bearer ${token}',
            },
          ));

      print(response.data);
      return Payments.listFromJson(response.data);
    } on DioException catch (e) {
      print(e);
      return [];
    }
  }

  postTransaction(double price, String bandeiraCartao, String meioPagamento,
      String codigoAutorizacao, String transactionId, bool status, String cnpj, String comprovante) async {

    Map<String,dynamic> data = {
      "price": price,
      "companyId": configurationController.id.value,
      "bandeiraCartao": bandeiraCartao,
      "cnpjInstituicao": cnpj,
      "meioPagamento": meioPagamento,
      "codigoAutorizacao": codigoAutorizacao,
      "transactionId": transactionId,
      "status": status,
      "comprovante":comprovante
    };
    print(data);
    try {
      var response = await dio.post(EndPoints.putPayments(),
          options: Options(
            headers: {
              'Authorization': 'Bearer ${companiesController.token.value}',
            },
          ),
          data:[data] );
      print("teste bernardo ${response.statusCode} ");
    } on DioException catch (e) {
      print(e);
    }
  }
}
