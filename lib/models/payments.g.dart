// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Payments _$PaymentsFromJson(Map<String, dynamic> json) => Payments()
  ..paymentMethod = json['paymentMethod'] as String
  ..price = (json['price'] as num).toDouble()
  ..companyId = json['companyId'] as int
  ..transactionId = json['transactionId'] as String;

Map<String, dynamic> _$PaymentsToJson(Payments instance) => <String, dynamic>{
      'paymentMethod': instance.paymentMethod,
      'price': instance.price,
      'companyId': instance.companyId,
      'transactionId': instance.transactionId,
    };
