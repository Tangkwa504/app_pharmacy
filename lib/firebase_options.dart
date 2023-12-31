// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDObWPoWYWwHczd9Gn_a96pgM577Q8m_mc',
    appId: '1:393149076304:web:9ec29cadb89879b788d255',
    messagingSenderId: '393149076304',
    projectId: 'project-online-medicine',
    authDomain: 'project-online-medicine.firebaseapp.com',
    databaseURL: 'https://project-online-medicine-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'project-online-medicine.appspot.com',
    measurementId: 'G-78Z181Y44K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrQgBSHfn2QNTEeiWdMr04nYJeHJArrzI',
    appId: '1:393149076304:android:cff2725810d8fdff88d255',
    messagingSenderId: '393149076304',
    projectId: 'project-online-medicine',
    databaseURL: 'https://project-online-medicine-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'project-online-medicine.appspot.com',
  );
}
