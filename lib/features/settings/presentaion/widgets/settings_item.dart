import 'package:flutter/material.dart';

import '../../../../core/extensions/context_extensions.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    Key? key,
    required this.title,
    required this.onTap,
    this.trailing = '',
  }) : super(key: key);
  final String title;
  final String trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.only(
        left: context.locale.localeName == 'en'
            ? context.screenSize.width * 0.048
            : 0.0,
        right: context.locale.localeName == 'ar'
            ? context.screenSize.width * 0.048
            : 0.0,
      ),
      leading: Text(title,
          style: context.textTheme.bodyText2!.copyWith(
            color: const Color(0xff484848),
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          )),
      trailing: SizedBox(
        width: context.screenSize.width * 0.31,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Flexible(
              child: Text(
                trailing,
                style: context.textTheme.bodyText2!.copyWith(
                  color: const Color(0xffababb7),
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0,
                ),
              ),
            ),
            Flexible(
              child: IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.adaptive.arrow_forward,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
