import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app.dart';
import 'package:mobile/simple_bloc_observer.dart';

import 'injection_container.dart' as di;

void main() async {
  Bloc.observer = const SimpleBlocObserver();

  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  await di.init();
  runApp(MyApp(savedThemeMode: savedThemeMode));
}
