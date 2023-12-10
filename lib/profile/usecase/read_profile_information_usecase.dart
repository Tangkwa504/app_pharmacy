import 'dart:async';
import 'dart:convert';

import 'package:app_pharmacy/core/application/usecase.dart';
import 'package:app_pharmacy/core/firebase/firebase_realtime/firebase_realtime_provider.dart';
import 'package:app_pharmacy/profile/enum/phamarcy_status_enum.dart';
import 'package:app_pharmacy/profile/model/response/profile_information_response.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';

@injectable
class ReadProfileInformationUseCase
    extends UseCase<String, ProfileInformationResponse> {
  ReadProfileInformationUseCase();

  @override
  Future<ProfileInformationResponse> exec(String request) async {
    final Completer<ProfileInformationResponse> completer =
        Completer<ProfileInformationResponse>();

    final collection = FirebaseRealtimeProvider.ref('Pharmacy/$request');
    collection.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      Map<String, dynamic> mapData = json.decode(json.encode(data));
      completer.complete(ProfileInformationResponse(
        addressShop: mapData["Addressshop"] ?? '',
        email: mapData["Email"] ?? '',
        id: mapData["Id"] ?? '',
        licensePharmacy: mapData["Licensepharmacy"] ?? '',
        name: mapData["Name"] ?? '',
        nameShop: mapData["Nameshop"] ?? '',
        password: mapData["Password"] ?? '',
        telNumber: mapData["Tel"] ?? '',
        timeClosing: mapData["Timeclosing"] ?? '',
        timeOpening: mapData["Timeopening"] ?? '',
        imgLicenseStoreUrl: mapData["img_license_store_url"] ?? '',
        imgLicenseUrl: mapData["img_license_url"] ?? '',
        imgQRCode: mapData["img_qr_code"] ?? '',
        latitude: mapData["latitude"] ?? 0.0,
        longitude: mapData["longitude"] ?? 0.0,
        status: PhamarcyStatus.values.byName(mapData['status'] ?? 'waiting'),
        profileImgUrl: mapData["profile_img_url"] ?? '',
      ));
    });

    return await completer.future;
  }
}
