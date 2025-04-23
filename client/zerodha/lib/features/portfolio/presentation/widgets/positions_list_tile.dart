import 'package:flutter/material.dart';
import 'package:zerodha/core/constants/app_color.dart';

class PositionsListTile extends StatelessWidget {
  const PositionsListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Qty. ',
                      style: Theme.of(context).textTheme.bodySmall,
                      children: <TextSpan>[
                        TextSpan(
                          text: '2',
                          style: Theme.of(context).textTheme.bodySmall,
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
                          Theme.of(context).brightness == Brightness.light
                              ? AppColor.blackColor
                              : AppColor.whiteColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      text: 'Avg. ',
                      style: Theme.of(context).textTheme.bodySmall,
                      children: <TextSpan>[
                        TextSpan(
                          text: '66.33',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: AppColor.blueColor.withValues(alpha: 0.1),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Text(
                  "NRML",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          key: UniqueKey(),
          title: Text(
            "RELIANCE",
            style: Theme.of(context).textTheme.labelSmall,
          ),
          subtitle: Text("CDS", style: Theme.of(context).textTheme.labelSmall),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "2924.50",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontSize: 14,
                  color: AppColor.greenColor,
                ),
              ),
              const SizedBox(height: 6),
              RichText(
                text: TextSpan(
                  text: 'LTP: ',
                  style: Theme.of(context).textTheme.labelSmall,
                  children: <TextSpan>[
                    TextSpan(
                      text: '70.00',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    TextSpan(
                      text: '(-0.56%)',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColor.greenColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
