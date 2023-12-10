import 'dart:async';
import 'dart:io';

import 'package:app_pharmacy/core/application/usecase.dart';
import 'package:app_pharmacy/core/firebase/firebase_realtime/firebase_realtime_provider.dart';
import 'package:app_pharmacy/core/firebase/firebase_storage/firebase_storage_provider.dart';
import 'package:app_pharmacy/profile/model/request/update_qr_code_request.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateQRCodeUsecase extends UseCase<UpdateQRCodeRequest, bool> {
  UpdateQRCodeUsecase();

  @override
  Future<bool> exec(UpdateQRCodeRequest request) async {
    try {
      final Completer<String> _completer = Completer<String>();

      final name = request.file.path.split('/').last;
      final storageRef = FirebaseStorageProvider.storage.ref('qr_code/$name');
      final uploadTask = storageRef.putFile(File(request.file.path));

      uploadTask.snapshotEvents.listen((taskSnapshot) async {
        switch (taskSnapshot.state) {
          case TaskState.success:
            _completer.complete(await storageRef.getDownloadURL());
            break;
          case TaskState.paused:
            break;
          case TaskState.running:
            break;
          case TaskState.canceled:
            _completer.complete('');
            break;
          case TaskState.error:
            _completer.complete('');
            break;
        }
      });

      final collection = FirebaseRealtimeProvider.ref('Pharmacy/${request.id}');

      await collection.update({
        'img_qr_code': await _completer.future,
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
