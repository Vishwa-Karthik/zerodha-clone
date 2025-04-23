import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zerodha/features/user/presentation/pages/users_page.dart';

class AccountActionListTile extends StatefulWidget {
  final List<AccountUserInteractionModel> accountUserInteractionModel;
  final Function(AccountUserInteractionModel, int) onPressed;

  const AccountActionListTile({
    super.key,
    required this.accountUserInteractionModel,
    required this.onPressed,
  });

  @override
  State<AccountActionListTile> createState() => _AccountActionListTileState();
}

class _AccountActionListTileState extends State<AccountActionListTile> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: widget.onPressed(
              widget.accountUserInteractionModel[index], index),
          child: ListTile(
            minTileHeight: MediaQuery.sizeOf(context).height * 0.04,
            contentPadding: const EdgeInsets.only(),
            title: Text(widget.accountUserInteractionModel[index].text ?? ""),
            titleTextStyle: Theme.of(context).textTheme.titleSmall,
            trailing: FaIcon(
                widget.accountUserInteractionModel[index].iconData ??
                    FontAwesomeIcons.a),
          ),
        );
      },
      separatorBuilder: (_, index) {
        return Divider(
          color: Colors.grey.shade200,
          thickness: 0.2,
        );
      },
      itemCount: widget.accountUserInteractionModel.length,
    );
  }
}
