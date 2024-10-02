import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'data/repositories/authentication_repository.dart';
import 'features/controllers/network_manager.dart';
import 'firebase_options.dart';

// Entry point of flutter app
Future<void> main() async {

  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized

  // Initialize GetStorage
  await GetStorage.init();

  // Preserve splash screen until initialization is complete
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
        (FirebaseApp value) => Get.put(AuthenticationRepository()),       // Register AuthenticationRepository after Firebase initialization
  );

  // Register NetworkManager after Firebase initialization
  Get.put(NetworkManager());


  // Run the app
  runApp(const App());
}
