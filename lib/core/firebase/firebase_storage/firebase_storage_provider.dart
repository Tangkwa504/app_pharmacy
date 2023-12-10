import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageProvider {
  FirebaseStorageProvider._();

  static FirebaseStorage get storage => FirebaseStorage.instance;
}
