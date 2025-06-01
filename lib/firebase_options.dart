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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAIxuHqdJHGRzv1hgBj1appsRw0BMqxrOU',
    appId: '1:232165675797:web:13326712f20f745dc10f1c',
    messagingSenderId: '232165675797',
    projectId: 'isl-kids-app-e5e12',
    authDomain: 'isl-kids-app-e5e12.firebaseapp.com',
    storageBucket: 'isl-kids-app-e5e12.firebasestorage.app',
    measurementId: 'G-6MQMFYR75W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8eb0S5N1Ozfc0cGz_DcS2izYoohmlEQk',
    appId: '1:232165675797:android:986a8e0260ba6f38c10f1c',
    messagingSenderId: '232165675797',
    projectId: 'isl-kids-app-e5e12',
    storageBucket: 'isl-kids-app-e5e12.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAbbnf4beIVk14K30gjLmtodAYRC7nwwlM',
    appId: '1:232165675797:ios:db5741fab40892b3c10f1c',
    messagingSenderId: '232165675797',
    projectId: 'isl-kids-app-e5e12',
    storageBucket: 'isl-kids-app-e5e12.firebasestorage.app',
    androidClientId: '232165675797-h0d2mqr6cu5hfbgkshi07qof26mn8ck3.apps.googleusercontent.com',
    iosClientId: '232165675797-kjs3129i6e73esf7t3kqrtvlc8dsfufb.apps.googleusercontent.com',
    iosBundleId: 'com.example.islKidsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAbbnf4beIVk14K30gjLmtodAYRC7nwwlM',
    appId: '1:232165675797:ios:db5741fab40892b3c10f1c',
    messagingSenderId: '232165675797',
    projectId: 'isl-kids-app-e5e12',
    storageBucket: 'isl-kids-app-e5e12.firebasestorage.app',
    androidClientId: '232165675797-h0d2mqr6cu5hfbgkshi07qof26mn8ck3.apps.googleusercontent.com',
    iosClientId: '232165675797-kjs3129i6e73esf7t3kqrtvlc8dsfufb.apps.googleusercontent.com',
    iosBundleId: 'com.example.islKidsApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAIxuHqdJHGRzv1hgBj1appsRw0BMqxrOU',
    appId: '1:232165675797:web:b73eb69e8cd0f5cbc10f1c',
    messagingSenderId: '232165675797',
    projectId: 'isl-kids-app-e5e12',
    authDomain: 'isl-kids-app-e5e12.firebaseapp.com',
    storageBucket: 'isl-kids-app-e5e12.firebasestorage.app',
    measurementId: 'G-YM8L0BPE0T',
  );

}