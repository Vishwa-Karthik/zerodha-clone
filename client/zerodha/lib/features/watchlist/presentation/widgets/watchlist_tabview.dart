import 'package:flutter/material.dart';
import 'package:zerodha/core/constants/app_color.dart';

class WatchlistTabview extends StatelessWidget {
  const WatchlistTabview({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(title: Text("TCS"), subtitle: Text("NSE"));
      },
      separatorBuilder: (context, index) {
        return Divider(color: AppColor.whiteColor);
      },
      itemCount: 10,
    );
  }
}
