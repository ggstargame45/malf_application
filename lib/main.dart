import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:malf_application/main/malf.dart';
import 'package:malf_application/main/observers.dart';

import 'features/chat/data/network/streamSocket.dart';

void main() {
  connectAndListen();
  runApp(ProviderScope(
    observers: [
      Observers(),
    ],
    child: MalfApp(),
  ));
}
