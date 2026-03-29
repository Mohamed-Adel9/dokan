import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:hive_flutter/adapters.dart';

import '../di/service_locator.dart';
import '../../firebase_options.dart';

class AppInitializer {
  static Future<void> init() async {
    await _initFirebase();
    await _initRemoteConfig();
    await _initPaymob();
    await _initLocalDb();
    await _initDI();
  }

  static Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  static Future<void> _initRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await remoteConfig.fetchAndActivate();
  }

  static Future<void> _initPaymob() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await FlutterPaymob.instance.initialize(
      apiKey: remoteConfig.getString('paymob_api_key'),
      integrationID: remoteConfig.getInt('paymob_card_id'),
      walletIntegrationId: remoteConfig.getInt('paymob_wallet_id'),
      iFrameID: remoteConfig.getInt('paymob_iframe_id'),
    );
  }

  static Future<void> _initLocalDb() async {
    await Hive.initFlutter();
  }

  static Future<void> _initDI() async {
    await init();
  }
}