// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_information_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProfileInformationResponseImpl _$$ProfileInformationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ProfileInformationResponseImpl(
      addressShop: json['addressShop'] as String,
      email: json['email'] as String,
      id: json['id'] as String,
      licensePharmacy: json['licensePharmacy'] as String,
      name: json['name'] as String,
      nameShop: json['nameShop'] as String,
      password: json['password'] as String,
      telNumber: json['telNumber'] as String,
      timeClosing: json['timeClosing'] as String,
      timeOpening: json['timeOpening'] as String,
      imgLicenseStoreUrl: json['imgLicenseStoreUrl'] as String,
      imgLicenseUrl: json['imgLicenseUrl'] as String,
      imgQRCode: json['imgQRCode'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      status: $enumDecode(_$PhamarcyStatusEnumMap, json['status']),
      profileImgUrl: json['profileImgUrl'] as String,
    );

Map<String, dynamic> _$$ProfileInformationResponseImplToJson(
        _$ProfileInformationResponseImpl instance) =>
    <String, dynamic>{
      'addressShop': instance.addressShop,
      'email': instance.email,
      'id': instance.id,
      'licensePharmacy': instance.licensePharmacy,
      'name': instance.name,
      'nameShop': instance.nameShop,
      'password': instance.password,
      'telNumber': instance.telNumber,
      'timeClosing': instance.timeClosing,
      'timeOpening': instance.timeOpening,
      'imgLicenseStoreUrl': instance.imgLicenseStoreUrl,
      'imgLicenseUrl': instance.imgLicenseUrl,
      'imgQRCode': instance.imgQRCode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'status': _$PhamarcyStatusEnumMap[instance.status]!,
      'profileImgUrl': instance.profileImgUrl,
    };

const _$PhamarcyStatusEnumMap = {
  PhamarcyStatus.waiting: 'waiting',
  PhamarcyStatus.approve: 'approve',
  PhamarcyStatus.canceled: 'canceled',
};
