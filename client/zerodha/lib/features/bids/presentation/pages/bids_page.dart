import 'package:flutter/material.dart';
import 'package:zerodha/core/constants/app_color.dart';
import 'package:zerodha/core/constants/app_constant.dart';


class BidsPage extends StatefulWidget {
  const BidsPage({super.key});

  @override
  State<BidsPage> createState() => _BidsPageState();
}

class _BidsPageState extends State<BidsPage>
    with SingleTickerProviderStateMixin {
  int selectedBidsIndex = 0;

  final List<Tab> bidsTabs = [
    Tab(text: "IPO"),
    Tab(text: "Govt. Securities"),
    Tab(text: "Auctions"),
  ];

  final TextEditingController searchTextController = TextEditingController();
  late TabController? tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: bidsTabs.length, vsync: this);
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
      length: bidsTabs.length,
      child: Padding(
        padding: EdgeInsets.all(AppConstant.double12),
        child: Column(
          children: [
            // 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Bids",
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
              indicatorColor: AppColor.blueColor,
              onTap: (int index) {
                setState(() {
                  selectedBidsIndex = index;
                });
              },
              tabs: bidsTabs,
            ),

            Expanded(
              child: Center(
                child: Text(
                  'No Bids Found',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
