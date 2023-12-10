import 'dart:async';
import 'dart:io';

import 'package:app_pharmacy/core/application/usecase.dart';
import 'package:app_pharmacy/core/firebase/firebase_storage/firebase_storage_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadLicensesPhamarcyStoreUsecase extends UseCase<XFile, String> {
  UploadLicensesPhamarcyStoreUsecase();

  @override
  Future<String> exec(XFile request) async {
    try {
      final Completer<String> _completer = Completer<String>();

      final name = request.path.split('/').last;
      final storageRef =
          FirebaseStorageProvider.storage.ref('licenses_store/$name');
      final uploadTask = storageRef.putFile(File(request.path));

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

      return await _completer.future;
    } catch (e) {
      return '';
    }
  }
}
