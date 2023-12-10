import 'dart:async';
import 'dart:io';

import 'package:app_pharmacy/core/application/usecase.dart';
import 'package:app_pharmacy/core/firebase/firebase_realtime/firebase_realtime_provider.dart';
import 'package:app_pharmacy/core/firebase/firebase_storage/firebase_storage_provider.dart';
import 'package:app_pharmacy/profile/model/request/change_profile_info_request.dart';
import 'package:app_pharmacy/profile/model/request/update_qr_code_request.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChangeProfileInfoUsecase extends UseCase<ChangeProfileInfoRequest, bool> {
  ChangeProfileInfoUsecase();

  @override
  Future<bool> exec(ChangeProfileInfoRequest request) async {
    try {
      final Completer<String> completerProfile = Completer<String>();
      final Completer<String> completerLicense = Completer<String>();

      final profileImg = request.profileImg.path.split('/').last;
      final licenseImg = request.licenseImg.path.split('/').last;

      final storageProfileRef = FirebaseStorageProvider.storage
          .ref('users/${request.email}/$profileImg');

      final uploadTaskProfile =
          storageProfileRef.putFile(File(request.profileImg.path));

      uploadTaskProfile.snapshotEvents.listen((taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.success:
            completerProfile.complete(await storageProfileRef.getDownloadURL());
            break;
          case TaskState.paused:
            break;
          case TaskState.running:
            break;
          case TaskState.canceled:
            completerProfile.complete('');
            break;
          case TaskState.error:
            completerProfile.complete('');
            break;
        }
      });

      final storageLicenseRef =
          FirebaseStorageProvider.storage.ref('licenses/$licenseImg');

      final uploadTaskLicense =
          storageLicenseRef.putFile(File(request.profileImg.path));

      uploadTaskLicense.snapshotEvents.listen((taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.success:
            completerLicense.complete(await storageLicenseRef.getDownloadURL());
            break;
          case TaskState.paused:
            break;
          case TaskState.running:
            break;
          case TaskState.canceled:
            completerLicense.complete('');
            break;
          case TaskState.error:
            completerLicense.complete('');
            break;
        }
      });

      final collection = FirebaseRealtimeProvider.ref('Pharmacy/${request.id}');

      await collection.update({
        'profile_img_url': await completerProfile.future,
        "img_license_url": await completerLicense.future,
        "Name": request.name,
        "Tel": request.tel,
        "Licensepharmacy": request.licensePharmacy,
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
