import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_frame/device_frame.dart';
import 'package:zerodha/core/constants/app_theme.dart';
import 'package:zerodha/features/dashboard/presentation/dashboard_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zerodha Clone',
      theme: AppTheme.light(),
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.dark(),
      home: kIsWeb ? WrappedDashboardPage() : const DashboardPage(),
    );
  }
}

class WrappedDashboardPage extends StatelessWidget {
  const WrappedDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DeviceFrame(
      isFrameVisible: true,
      device: Devices.ios.iPhone13ProMax,
      screen: const DashboardPage(),
    );
  }
}
