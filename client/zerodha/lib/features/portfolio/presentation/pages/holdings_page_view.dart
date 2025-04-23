import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;
import 'package:zerodha/core/constants/app_color.dart';
import 'package:zerodha/core/constants/app_constant.dart';
import 'package:zerodha/features/portfolio/presentation/widgets/holdings_list_tile.dart';

class HoldingsView extends StatelessWidget {
  const HoldingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: AppColor.oliveColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.3),
                  blurRadius: 1,
                  spreadRadius: 0.1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Invested",
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(color: AppColor.greyColor),
                          ),
                          Text(
                            "22,546",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(color: AppColor.greyColor),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Current",
                            style: Theme.of(context).textTheme.labelMedium
                                ?.copyWith(color: AppColor.greyColor),
                          ),
                          Text(
                            "1,23,546",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(color: AppColor.greyColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "P&L",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: AppColor.greyColor),
                      ),
                      Row(
                        children: [
                          Text(
                            "+ 2530.16",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(color: AppColor.greenColor),
                          ),
                          const SizedBox(width: 8),
                          Chip(
                            backgroundColor: Colors.green.withValues(
                              alpha: 0.4,
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              side: BorderSide(color: Colors.transparent),
                            ),
                            color: WidgetStateProperty.all(
                              Colors.green.withValues(alpha: 0.4),
                            ),
                            label: Text(
                              "+ 15.16%",
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(color: AppColor.greenColor),
                            ),
                            padding: EdgeInsets.zero,
                            visualDensity: const VisualDensity(
                              horizontal: -4,
                              vertical: -4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    IconButton(
                      icon: const FaIcon(FontAwesomeIcons.lock),
                      color: AppColor.blueColor,
                      onPressed: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton.icon(
                      icon: FaIcon(
                        FontAwesomeIcons.userGroup,
                        color: AppColor.blueColor,
                        size: 13,
                      ),
                      onPressed: () {},
                      label: Text(
                        "Family",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColor.blueColor,
                        ),
                      ),
                    ),
                    TextButton.icon(
                      icon: FaIcon(
                        FontAwesomeIcons.chartPie,
                        color: AppColor.blueColor,
                        size: 13,
                      ),
                      onPressed: () {},
                      label: Text(
                        "Analytics",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColor.blueColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(height: 0, color: AppColor.greyColor, thickness: 0.1),
          ],
        ),
        Expanded(
          child: ListView.separated(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              return HoldingsListTile();
            },
            separatorBuilder: (_, index) {
              return Divider(
                height: 0,
                color: AppColor.greyColor,
                thickness: 0.1,
              );
            },
          ),
        ),
      ],
    );
  }
}
