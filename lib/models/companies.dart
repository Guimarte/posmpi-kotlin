import 'package:json_annotation/json_annotation.dart';

part 'companies.g.dart';

@JsonSerializable()

class Companies {
  int? id;
  String? city;
  String? cnpj;
  String? corporateName;
  String? fantasyName;
  String? phone;
  String? certificateExpiration;
  String? status;

Companies();

  static List<Companies> listFromJson(List list){
    List<Companies> listReturn = [];
    list.forEach((element) {
      Companies payments = Companies.fromJson(element);
      listReturn.add(payments);
    });
    return listReturn;
  }

  factory Companies.fromJson(Map<String,dynamic> json) =>_$CompaniesFromJson(json);

  Map<String,dynamic> toJson()=> _$CompaniesToJson(this);
}

