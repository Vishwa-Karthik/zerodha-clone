import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zerodha/features/user/presentation/pages/users_page.dart';

class AccountActionListTile extends StatelessWidget {
  final List<AccountUserInteractionModel> accountUserInteractionModel;
  final Function(AccountUserInteractionModel, int) onPressed;

  const AccountActionListTile({
    super.key,
    required this.accountUserInteractionModel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: onPressed(accountUserInteractionModel[index], index),
          child: ListTile(
            minTileHeight: MediaQuery.sizeOf(context).height * 0.04,
            contentPadding: const EdgeInsets.only(),
            title: Text(accountUserInteractionModel[index].text ?? ""),
            titleTextStyle: Theme.of(context).textTheme.titleSmall,
            trailing: FaIcon(
              accountUserInteractionModel[index].iconData ?? FontAwesomeIcons.a,
            ),
          ),
        );
      },
      separatorBuilder: (_, index) {
        return Divider();
      },
      itemCount: accountUserInteractionModel.length,
    );
  }
}
