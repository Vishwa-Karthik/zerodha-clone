import 'package:flutter/material.dart';
import 'package:zerodha/features/portfolio/presentation/pages/holdings_page_view.dart';
import 'package:zerodha/features/portfolio/presentation/pages/positions_page_view.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  int selectPortfolioIndex = 0;

  final List<Tab> portfolioTabs = [
    Tab(text: "Holdings"),
    Tab(text: "Positions"),
  ];
  late TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: portfolioTabs.length, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: portfolioTabs.length,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            // 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Portfolio",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.expand_more_rounded),
                  iconSize: 32,
                ),
              ],
            ),

            // 2
            TabBar(
              controller: tabController,
              onTap: (int index) {
                setState(() {
                  selectPortfolioIndex = index;
                });
              },
              tabs: portfolioTabs,
            ),

            // 3
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [HoldingsView(), PositionsView()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
