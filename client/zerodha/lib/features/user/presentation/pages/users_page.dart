import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zerodha/core/constants/app_color.dart';
import 'package:zerodha/core/constants/app_constant.dart';
import 'package:zerodha/features/user/presentation/providers/privacy_mode_provider.dart';
import 'package:zerodha/features/user/presentation/widgets/account_action_list_tile.dart';

class UsersPage extends ConsumerWidget {
  const UsersPage({super.key});

  static final List<AccountUserInteractionModel> accountUserInteractionModel = [
    AccountUserInteractionModel(
      index: 1,
      text: "Funds",
      iconData: FontAwesomeIcons.indianRupeeSign,
    ),
    AccountUserInteractionModel(
      index: 2,
      text: "App Code",
      iconData: FontAwesomeIcons.unlock,
    ),
    AccountUserInteractionModel(
      index: 3,
      text: "Profile",
      iconData: FontAwesomeIcons.user,
    ),
    AccountUserInteractionModel(
      index: 4,
      text: "Settings",
      iconData: FontAwesomeIcons.gear,
    ),
    AccountUserInteractionModel(
      index: 5,
      text: "Connected Apps",
      iconData: FontAwesomeIcons.cube,
    ),
    AccountUserInteractionModel(
      index: 6,
      text: "Logout",
      iconData: FontAwesomeIcons.arrowRightFromBracket,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final privacyMode = ref.watch(privacyModeProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Account",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
            const SizedBox(height: 10),
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Vishwa Karthik",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.bell),
                ),
              ],
            ),
            const SizedBox(height: 10),
            //
            Container(
              height: MediaQuery.sizeOf(context).height * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8),
                color: AppColor.oliveColor,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "VK0000",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColor.whiteColor,
                              ),
                            ),
                            Text(
                              AppConstant.email,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          minRadius: MediaQuery.sizeOf(context).height * 0.04,
                          backgroundColor: AppColor.blueColor.withValues(
                            alpha: 0.2,
                          ),
                          child: Center(
                            child: Text(
                              "VK",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    color: Colors.black12,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Row(
                        spacing: 12,
                        children: [
                          Text(
                            "Privacy Mode",
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppColor.whiteColor,
                            ),
                          ),
                          Switch.adaptive(
                            inactiveTrackColor: AppColor.greyColor.withValues(
                              alpha: 0.5,
                            ),
                            value: privacyMode,
                            onChanged: (bool value) {
                              ref.read(privacyModeProvider.notifier).state =
                                  value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            //
            Text(
              "Account",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColor.greyColor),
            ),

            Divider(),

            //
            AccountActionListTile(
              accountUserInteractionModel: accountUserInteractionModel,
              onPressed: (accountUserInteractionModel, index) {},
            ),
          ],
        ),
      ),
    );
  }
}

class AccountUserInteractionModel {
  final int? index;
  final String? text;
  final IconData? iconData;

  AccountUserInteractionModel({
    required this.index,
    required this.text,
    required this.iconData,
  });
}
