import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:device_frame/device_frame.dart';
import 'package:zerodha/core/theme/app_theme.dart';
import 'package:zerodha/features/bids/presentation/pages/bids_page.dart';
import 'package:zerodha/features/orders/presentation/pages/orders_page.dart';
import 'package:zerodha/features/portfolio/presentation/pages/portfolio_page.dart';
import 'package:zerodha/features/user/presentation/pages/users_page.dart';
import 'package:zerodha/features/watchlist/presentation/pages/watchlist_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: kIsWeb ? WrappedHomePage() : const HomePage(),
    );
  }
}

class WrappedHomePage extends StatelessWidget {
  const WrappedHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DeviceFrame(
      isFrameVisible: true,
      device: Devices.ios.iPhone13ProMax,
      screen: const HomePage(),
      
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<BottomNavigationBarItem> bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.bookmark),
      label: "Watchlist",
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.book),
      label: "Orders",
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.suitcase),
      label: "Portfolio",
    ),
    BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.gavel),
      label: "Bids",
    ),
    BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.user), label: "User"),
  ];

  final List<Widget> body = [
    WatchListPage(),
    OrdersPage(),
    PortfolioPage(),
    BidsPage(),
    UsersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Banner(
      message: "CLONE",
      location: BannerLocation.topEnd,
      child: SafeArea(
        child: Scaffold(
          body: body[selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: bottomNavBarItems,
            onTap: (int index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
