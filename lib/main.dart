import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'package:malf_application/main/observers.dart';
import 'package:malf_application/main/malf.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: '9f2ca74fe6069a97f50ccfabf696f89f');
  runApp(ProviderScope(
    observers: [
      Observers(),
    ],
    child: MalfApp(),
  ));
}
