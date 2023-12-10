import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeProvider {
  FirebaseRealtimeProvider._();

  static DatabaseReference ref(String path) {
    return FirebaseDatabase.instance.ref(path);
  }
}
