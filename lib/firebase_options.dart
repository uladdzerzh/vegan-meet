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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyCdshPyaP5S208UgsiZwDcK0JinmzSJU1A',
    appId: '1:1076187818833:web:67fa5f2ea14ca28b280170',
    messagingSenderId: '1076187818833',
    projectId: 'vegan-meet-76339',
    authDomain: 'vegan-meet-76339.firebaseapp.com',
    databaseURL: 'https://vegan-meet-76339-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'vegan-meet-76339.appspot.com',
    measurementId: 'G-RR42RH73ZT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDuCQ9I-mwFwyCqSkDGKp7GBlNmHUekHw8',
    appId: '1:1076187818833:android:0a94057487729007280170',
    messagingSenderId: '1076187818833',
    projectId: 'vegan-meet-76339',
    databaseURL: 'https://vegan-meet-76339-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'vegan-meet-76339.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCqucrX2UmNJ_y-3HEXaZZwaRQZb1u4PAc',
    appId: '1:1076187818833:ios:38ddf9ad22bd57c0280170',
    messagingSenderId: '1076187818833',
    projectId: 'vegan-meet-76339',
    databaseURL: 'https://vegan-meet-76339-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'vegan-meet-76339.appspot.com',
    iosClientId: '1076187818833-t0d77idjtpjmov3da8qkntnr840qpedr.apps.googleusercontent.com',
    iosBundleId: 'com.example.veganMeet',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCqucrX2UmNJ_y-3HEXaZZwaRQZb1u4PAc',
    appId: '1:1076187818833:ios:38ddf9ad22bd57c0280170',
    messagingSenderId: '1076187818833',
    projectId: 'vegan-meet-76339',
    databaseURL: 'https://vegan-meet-76339-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'vegan-meet-76339.appspot.com',
    iosClientId: '1076187818833-t0d77idjtpjmov3da8qkntnr840qpedr.apps.googleusercontent.com',
    iosBundleId: 'com.example.veganMeet',
  );
}
