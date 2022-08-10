import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/core.dart';

class EmptyNotifications extends StatelessWidget {
  const EmptyNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            noNotificationsIcon,
            height: 130,
          ),
          const SizedBox(height: 30),
          Text(
            context.locale.emptyNotifications,
            style: context.textTheme.headline6!.copyWith(
              color: const Color(0XFFababb7),
            ),
          ),
        ],
      ),
    );
  }
}
