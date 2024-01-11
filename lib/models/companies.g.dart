// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Companies _$CompaniesFromJson(Map<String, dynamic> json) => Companies()
  ..id = json['id'] as int?
  ..city = json['city'] as String?
  ..cnpj = json['cnpj'] as String?
  ..corporateName = json['corporateName'] as String?
  ..fantasyName = json['fantasyName'] as String?
  ..phone = json['phone'] as String?
  ..certificateExpiration = json['certificateExpiration'] as String?
  ..status = json['status'] as String?;

Map<String, dynamic> _$CompaniesToJson(Companies instance) => <String, dynamic>{
      'id': instance.id,
      'city': instance.city,
      'cnpj': instance.cnpj,
      'corporateName': instance.corporateName,
      'fantasyName': instance.fantasyName,
      'phone': instance.phone,
      'certificateExpiration': instance.certificateExpiration,
      'status': instance.status,
    };
