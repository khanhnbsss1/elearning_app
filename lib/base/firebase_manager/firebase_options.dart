// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIAMuapIP85deFBkBA8YLGchewjMOCEes',
    appId: '1:577388184102:android:68ccfa0dda807ee7abdce7',
    messagingSenderId: '577388184102',
    projectId: 'elearning-ca768',
    storageBucket: 'elearning-ca768.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCitq3FDRIwfhlQIiunUS5_-pK-NAxeOWE',
    appId: '1:577388184102:ios:cfca5778f17c05edabdce7',
    messagingSenderId: '577388184102',
    projectId: 'elearning-ca768',
    storageBucket: 'elearning-ca768.appspot.com',
    androidClientId: '577388184102-400mjsugm1v10bgcq9ubkdfoe4b24lod.apps.googleusercontent.com',
    iosClientId: '577388184102-iumlma6tp7nogajc0lc4pbirrge6t6f8.apps.googleusercontent.com',
    iosBundleId: 'FFTCompany.elearninglms',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBMUnrD5uaHYWrOB7iDQEzgvZF_JAlhiPY',
    appId: '1:577388184102:web:23f30b9d254c29cfabdce7',
    messagingSenderId: '577388184102',
    projectId: 'elearning-ca768',
    authDomain: 'elearning-ca768.firebaseapp.com',
    storageBucket: 'elearning-ca768.appspot.com',
    measurementId: 'G-5YL19Q7B8P',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCitq3FDRIwfhlQIiunUS5_-pK-NAxeOWE',
    appId: '1:577388184102:ios:eb377ba833aa0386abdce7',
    messagingSenderId: '577388184102',
    projectId: 'elearning-ca768',
    storageBucket: 'elearning-ca768.appspot.com',
    androidClientId: '577388184102-400mjsugm1v10bgcq9ubkdfoe4b24lod.apps.googleusercontent.com',
    iosClientId: '577388184102-s7bqus4i931udkn74p4gvdt34vlm7gjg.apps.googleusercontent.com',
    iosBundleId: 'n',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBMUnrD5uaHYWrOB7iDQEzgvZF_JAlhiPY',
    appId: '1:577388184102:web:6a4ae8aa35ca249aabdce7',
    messagingSenderId: '577388184102',
    projectId: 'elearning-ca768',
    authDomain: 'elearning-ca768.firebaseapp.com',
    storageBucket: 'elearning-ca768.appspot.com',
    measurementId: 'G-L65JT2SXXM',
  );

}