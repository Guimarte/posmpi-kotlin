
import 'package:json_annotation/json_annotation.dart';

part 'payments.g.dart';

@JsonSerializable()

class Payments{
  late String paymentMethod;
  late double price;
  late int companyId;
  late String transactionId;

  Payments();

  static List<Payments> listFromJson(List list){
    List<Payments> listReturn = [];
    list.forEach((element) {
      Payments payments = Payments.fromJson(element);
      listReturn.add(payments);
    });
    return listReturn;
  }

  factory Payments.fromJson(Map<String,dynamic> json) =>_$PaymentsFromJson(json);

  Map<String,dynamic> toJson()=> _$PaymentsToJson(this);
}