import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'package:malf_application/main/observers.dart';
import 'package:malf_application/main/malf.dart';

void main() {
  runApp(ProviderScope(
    observers: [
      Observers(),
    ],
    child: MalfApp(),
  ));
}
