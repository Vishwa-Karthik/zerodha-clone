import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zerodha/core/constants/app_color.dart';
import 'package:zerodha/core/constants/app_constant.dart';
import 'package:zerodha/core/utils/debouncer.dart';
import 'package:zerodha/features/watchlist/providers/stocks_provider.dart';
import 'package:zerodha/features/watchlist/providers/watch_list_provider.dart';

class WatchListPage extends ConsumerStatefulWidget {
  const WatchListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WatchListPageState();
}

class _WatchListPageState extends ConsumerState<WatchListPage>
    with SingleTickerProviderStateMixin {
  final List<Tab> watchlistTabs = [
    Tab(text: "Watchlist 0"),
    Tab(text: "Watchlist 1"),
    Tab(text: "Watchlist 2"),
    Tab(text: "Watchlist 3"),
  ];
  final TextEditingController searchTextController = TextEditingController();
  late TabController? tabController;
  final Debouncer _debouncer = Debouncer(milliseconds: 300);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: watchlistTabs.length, vsync: this);
  }

  @override
  void dispose() {
    searchTextController.dispose();
    tabController?.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stockState = ref.watch(stockStateProvider);
    final selectedWatchlistNotifier = ref.read(
      selectedWatchlistProvider.notifier,
    );
    return DefaultTabController(
      length: watchlistTabs.length,
      child: Padding(
        padding: EdgeInsets.all(AppConstant.double12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Watchlist",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.expand_more_rounded),
                  iconSize: 42,
                ),
              ],
            ),

            TabBar(
              controller: tabController,
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              indicatorColor: AppColor.blueColor,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 25),
              onTap: (int index) {
                selectedWatchlistNotifier.state = index;
              },
              tabs: watchlistTabs,
            ),

            const SizedBox(height: 20),
            SearchBar(
              controller: searchTextController,
              hintText: "Search & Add",
              onChanged: (String value) async {
                _debouncer.run(() {
                  ref.read(stockStateProvider.notifier).filterStocks(value);
                });
              },
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.characters,
              side: WidgetStatePropertyAll(BorderSide.none),
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: AppConstant.double12),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstant.double8),
                ),
              ),
              trailing: [
                stockState.when(
                  loading: () => Text("10 / 20"),
                  error: (error, stackTrace) => Text("10 / 20"),
                  data: (stocks) {
                    return Text(
                      "10 / ${stockState.value?.length.toString() ?? "0"}",
                    );
                  },
                ),
                SizedBox(width: AppConstant.double10),
                Container(width: 1, height: 15, color: Colors.grey),
                SizedBox(width: AppConstant.double10),
                GestureDetector(
                  onTap: () => showBottomSheet(context),
                  child: Transform.rotate(
                    angle: math.pi / 2,
                    child: Icon(Icons.tune_rounded, size: AppConstant.double24),
                  ),
                ),
              ],
              leading: FaIcon(FontAwesomeIcons.magnifyingGlass),
            ),

            const SizedBox(height: 20),

            stockState.when(
              loading:
                  () => Expanded(
                    child: Center(
                      child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColor.redColor,
                        ),
                      ),
                    ),
                  ),
              error:
                  (error, stackTrace) => Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          error.toString(),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            ref
                                .read(stockStateProvider.notifier)
                                .retryConnection();
                          },
                          child: const Text("Retry"),
                        ),
                      ],
                    ),
                  ),
              data:
                  (stocks) =>
                      stocks.isEmpty
                          ? Center(
                            child: Text(
                              "No stocks found",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )
                          : Expanded(
                            child: ListView.separated(
                              itemCount: stocks.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext _, int index) {
                                final stock = stocks[index];
                                return ListTile(
                                  dense: true,
                                  title: Text(
                                    stock.ticker ?? "",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  subtitle: Text(
                                    index % 2 == 0 ? "BSE" : "NSE",
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  trailing: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        stock.ticker ?? "",
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.copyWith(
                                          color:
                                              (stock.change ?? 0) > 0
                                                  ? AppColor.greenColor
                                                  : AppColor.redColor,
                                        ),
                                      ),
                                      Text(
                                        "${stock.change?.toStringAsFixed(2) ?? ""} ${stock.changePct?.toStringAsFixed(2) ?? ""}",
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext _, int index) {
                                return Divider(
                                  color: Colors.grey.shade200,
                                  thickness: 0.1,
                                );
                              },
                            ),
                          ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showBottomSheet(BuildContext context) async {
    return showModalBottomSheet(
      context: context,
      isDismissible: true,
      backgroundColor: AppColor.blackColor,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Filter"),
                  TextButton(onPressed: () {}, child: Text("Clear")),
                ],
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: AppConstant.double14,
                alignment: WrapAlignment.start,
                children: [
                  ActionChip(label: Text('NSE'), onPressed: () {}),
                  ActionChip(label: Text('BSE'), onPressed: () {}),
                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sort"),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.cloud_upload_outlined),
                  ),
                ],
              ),

              ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                leading: IconButton(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.arrowDownAZ),
                ),
                title: Text("Alphabetically"),
              ),
              Divider(),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,

                leading: IconButton(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.arrowDownAZ),
                ),
                title: Text("Change"),
              ),
              Divider(),
              ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,

                leading: CircleAvatar(
                  backgroundColor: AppColor.transparentColor,
                  child: Text("LTP"),
                ),
                title: Text("Last Traded Price"),
              ),
            ],
          ),
        );
      },
    );
  }
}
