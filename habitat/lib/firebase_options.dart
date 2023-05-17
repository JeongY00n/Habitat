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
    apiKey: 'AIzaSyCJpcASip66DnvcMytJIhAtzG_k4nuHk9o',
    appId: '1:717538880248:web:f5c4a5095dad876498690d',
    messagingSenderId: '717538880248',
    projectId: 'habitat-bf6d3',
    authDomain: 'habitat-bf6d3.firebaseapp.com',
    storageBucket: 'habitat-bf6d3.appspot.com',
    measurementId: 'G-4N60NPR41R',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC39WhvfiUvx5axijbo7Um88fOktBbDDdE',
    appId: '1:717538880248:android:7b001e6a886fcd0398690d',
    messagingSenderId: '717538880248',
    projectId: 'habitat-bf6d3',
    storageBucket: 'habitat-bf6d3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDtJeXbe3FfiQArHA9Jbbcq5tdLM5rCoo8',
    appId: '1:717538880248:ios:a9f3a3418498d8a198690d',
    messagingSenderId: '717538880248',
    projectId: 'habitat-bf6d3',
    storageBucket: 'habitat-bf6d3.appspot.com',
    androidClientId:
        '717538880248-7imbroeftif5qko51mf62jq08od9mh07.apps.googleusercontent.com',
    iosClientId:
        '717538880248-uihelbb159rt54af6f0bh0h7ca9tuakr.apps.googleusercontent.com',
    iosBundleId: 'com.status200.habitat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDtJeXbe3FfiQArHA9Jbbcq5tdLM5rCoo8',
    appId: '1:717538880248:ios:2a40ba7bac59ee4e98690d',
    messagingSenderId: '717538880248',
    projectId: 'habitat-bf6d3',
    storageBucket: 'habitat-bf6d3.appspot.com',
    androidClientId:
        '717538880248-7imbroeftif5qko51mf62jq08od9mh07.apps.googleusercontent.com',
    iosClientId:
        '717538880248-vj28rba0ikb6k4u94nu46ekq11q20pff.apps.googleusercontent.com',
    iosBundleId: 'com.status200.habitat.RunnerTests',
  );
}