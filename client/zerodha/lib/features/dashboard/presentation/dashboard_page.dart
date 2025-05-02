import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zerodha/features/bids/presentation/pages/bids_page.dart';
import 'package:zerodha/features/dashboard/providers/bottom_index_provider.dart';
import 'package:zerodha/features/orders/presentation/pages/orders_page.dart';
import 'package:zerodha/features/portfolio/presentation/pages/portfolio_page.dart';
import 'package:zerodha/features/user/presentation/pages/users_page.dart';
import 'package:zerodha/features/watchlist/presentation/pages/watchlist_page.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  static final List<BottomNavigationBarItem> bottomNavBarItems = [
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

  static final List<Widget> body = [
    WatchListPage(),
    OrdersPage(),
    PortfolioPage(),
    BidsPage(),
    UsersPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomIndeProvider);
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
            selectedFontSize:
                Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14,
            unselectedFontSize:
                Theme.of(context).textTheme.bodyMedium?.fontSize ?? 14,
            onTap: (int index) {
              ref.read(bottomIndeProvider.notifier).state = index;
            },
          ),
        ),
      ),
    );
  }
}
