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
    apiKey: 'AIzaSyBBscvezcxgWq1CvW7oNacj2hXRie1Wks0',
    appId: '1:937839443968:web:66d98e9e6164c7fbbc18e5',
    messagingSenderId: '937839443968',
    projectId: 'cidadnia-ativa',
    authDomain: 'cidadnia-ativa.firebaseapp.com',
    storageBucket: 'cidadnia-ativa.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDN9RawoczLhSRLR0fnY_9y3t-fUHJQuD0',
    appId: '1:937839443968:android:7235003f290cfba7bc18e5',
    messagingSenderId: '937839443968',
    projectId: 'cidadnia-ativa',
    storageBucket: 'cidadnia-ativa.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmfBSDGHeAgwLo1zZXBnaFWXDboxzwc1s',
    appId: '1:937839443968:ios:2a434e2c2eec71b2bc18e5',
    messagingSenderId: '937839443968',
    projectId: 'cidadnia-ativa',
    storageBucket: 'cidadnia-ativa.appspot.com',
    iosClientId: '937839443968-e7pnlsb4o8jddsgs5cglng18e01t80v9.apps.googleusercontent.com',
    iosBundleId: 'com.example.cidadaniaParticipativa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCmfBSDGHeAgwLo1zZXBnaFWXDboxzwc1s',
    appId: '1:937839443968:ios:5d09e2f8dac89c50bc18e5',
    messagingSenderId: '937839443968',
    projectId: 'cidadnia-ativa',
    storageBucket: 'cidadnia-ativa.appspot.com',
    iosClientId: '937839443968-52ak761cspfq3grvpfegf4lusg02phc2.apps.googleusercontent.com',
    iosBundleId: 'com.example.cidadaniaParticipativa.RunnerTests',
  );
}
