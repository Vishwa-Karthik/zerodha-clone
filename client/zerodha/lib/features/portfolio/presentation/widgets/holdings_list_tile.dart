import 'package:flutter/material.dart';
import 'package:zerodha/core/constants/app_color.dart';

class HoldingsListTile extends StatelessWidget {
  const HoldingsListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          dense: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Qty. ',
                  style: Theme.of(context).textTheme.labelMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: '2',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      Theme.of(context).brightness == Brightness.dark
                          ? AppColor.whiteColor
                          : Colors.black,
                ),
              ),
              const SizedBox(width: 8),
              RichText(
                text: TextSpan(
                  text: 'Avg. ',
                  style: Theme.of(context).textTheme.labelMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: '66.33',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          trailing: Text(
            "+ 5.03%",
            style: Theme.of(
              context,
            ).textTheme.labelMedium?.copyWith(color: AppColor.greenColor),
          ),
        ),
        ListTile(
          key: UniqueKey(),
          title: Text(
            "RELIANCE",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          subtitle: RichText(
            text: TextSpan(
              text: 'Invested ',
              style: Theme.of(context).textTheme.labelMedium,
              children: <TextSpan>[
                TextSpan(
                  text: '133.30',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "2924.50",
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(color: AppColor.greenColor),
              ),
              const SizedBox(height: 6),
              RichText(
                text: TextSpan(
                  text: 'LTP: ',
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: <TextSpan>[
                    TextSpan(
                      text: '70.00',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextSpan(
                      text: '(-0.56%)',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
