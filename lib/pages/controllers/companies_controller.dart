import 'package:get/get.dart';
import 'package:posmpi_kotlin/models/companies.dart';

import '../../models/payments.dart';
import '../../requesters/requesters.dart';

class CompaniesController extends GetxController {




  RxString token = "".obs;
  RxList<Companies>? companies = <Companies>[].obs;
  Companies companieSelected = Companies();
  RxBool isSelected = false.obs;
  RxBool isLoading = false.obs;

  RxList<Payments> payments = <Payments> [].obs;



 buscaVendas(String token, int id)async{

   isLoading.value = true;
   payments.clear();
    payments.value = await Requesters()
        .getTransaction(token,
       id);
   isLoading.value = false;
    return  payments.value;
  }


}
