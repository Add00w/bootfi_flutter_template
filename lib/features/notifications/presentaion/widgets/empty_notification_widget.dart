// import '../../../../core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/fixed_assets.dart' as fixed_assets;

class EmptyNotifications extends StatelessWidget {
  const EmptyNotifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            fixed_assets.noNotifications,
            height: 130,
          ),
          const SizedBox(height: 30),
          Text(
            'No notifications',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: const Color(0XFFababb7),
                ),
          ),
        ],
      ),
    );
  }
}
