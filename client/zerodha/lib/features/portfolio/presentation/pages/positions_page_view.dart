import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zerodha/core/constants/app_color.dart';
import 'package:zerodha/core/constants/app_constant.dart';
import 'dart:math' as math;
import 'package:zerodha/features/portfolio/presentation/widgets/positions_list_tile.dart';

class PositionsView extends StatelessWidget {
  const PositionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.search),
              color: AppColor.blueColor,
              onPressed: () {},
            ),
            InkWell(
              onTap: () {},
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Transform.rotate(
                angle: math.pi / 2,
                child: Icon(
                  Icons.tune_rounded,
                  color: AppColor.blueColor,
                  size: AppConstant.double24,
                ),
              ),
            ),
            const Spacer(),
            TextButton.icon(
              icon: FaIcon(
                FontAwesomeIcons.chartPie,
                color: AppColor.blueColor,
                size: 13,
              ),
              onPressed: () {},
              label: Text(
                "Analytics",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColor.blueColor),
              ),
            ),
          ],
        ),
        Divider(color: AppColor.greyColor, thickness: 0.1),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: AppColor.oliveColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                blurRadius: 1,
                spreadRadius: 0.1,
              ),
            ],
          ),
          height: 100,
          alignment: Alignment.center,
          child: const Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Total P&L",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
                Text(
                  "-2271.25",
                  style: TextStyle(color: Colors.red, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return PositionsListTile();
            },
            itemCount: 50,
          ),
        ),
      ],
    );
  }
}
