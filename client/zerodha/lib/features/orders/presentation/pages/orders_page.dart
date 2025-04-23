import 'package:flutter/material.dart';
import 'package:zerodha/core/constants/app_color.dart';
import 'package:zerodha/core/constants/app_constant.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
  int selectedOrderIndex = 0;

  final List<Tab> orderTabs = [
    Tab(text: "Open"),
    Tab(text: "Executed"),
    Tab(text: "GTT"),
    Tab(text: "Baskets"),
    Tab(text: "SIPs"),
    Tab(text: "Alerts"),
  ];
  final TextEditingController searchTextController = TextEditingController();
  late TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: orderTabs.length, vsync: this);
  }

  @override
  void dispose() {
    searchTextController.dispose();
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: orderTabs.length,
      child: Padding(
        padding: EdgeInsets.all(AppConstant.double12),
        child: Column(
          children: [
            // 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Orders",
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

            //2
            TabBar(
              controller: tabController,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              indicatorColor: AppColor.blueColor,
              onTap: (int index) {
                setState(() {
                  selectedOrderIndex = index;
                });
              },
              tabs: orderTabs,
            ),

            //
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No Pending Orders",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "Place an order from your watchlist",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
