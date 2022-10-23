import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mycloud/iken_coin.dart';
import 'config/config.dart';

const kColormain = Color.fromARGB(255, 16, 47, 138);
const kColorSecond = Color.fromARGB(255, 158, 189, 255);
const kButtonColor = Color.fromARGB(255, 52, 81, 156);

final configurations = Configurations();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase初期化
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: configurations.apiKey,
          appId: configurations.appId,
          messagingSenderId: configurations.messagingSenderId,
          projectId: configurations.projectId));
  runApp(
    ProviderScope(
      child: IkenCoin(),
    ),
  );
}
