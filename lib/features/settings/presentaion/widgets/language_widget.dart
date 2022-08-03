import 'package:flutter/material.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({
    Key? key,
    required this.language,
    required this.languageSelected,
    required this.selected,
  }) : super(key: key);
  final String language;
  final bool selected;
  final VoidCallback languageSelected;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        language,
        style: Theme.of(context).textTheme.bodyText2,
      ),
      trailing: selected
          ? const Icon(
              Icons.check_rounded,
              color: Color(0xff00a2f6),
            )
          : const SizedBox.shrink(),
      onTap: languageSelected,
    );
  }
}
