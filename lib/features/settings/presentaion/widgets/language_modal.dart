import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/core.dart';
import '../../settings.dart';

class LanguageModalBottomSheet extends ConsumerWidget {
  const LanguageModalBottomSheet() : super(key: const Key('LanguageModal'));
  @override
  Widget build(BuildContext context, ref) {
    final selectedLocale = ref.watch(selectedLocaleProvider);
    final languages = ref.read(supportedLanguagesProvider);
    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Color(0x29000000),
              offset: Offset(0, -6),
              blurRadius: 26,
              spreadRadius: 0)
        ],
      ),
      child: Column(
        children: [
          const _BottomSheetHeader(),
          for (int index = 0; index < languages.length; index++)
            LanguageWidget(
              key: Key('$index'),
              language: languages.elementAt(index),
              selected: selectedLocale ==
                  languageToLocale(languages.elementAt(index)),
              languageSelected: () {
                ref.read(selectedLocaleProvider.notifier).state =
                    languageToLocale(
                  languages.elementAt(index),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _BottomSheetHeader extends ConsumerWidget {
  const _BottomSheetHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 36,
          height: 4,
          decoration: BoxDecoration(
            color: const Color(0xff707070).withOpacity(0.4399999976158142),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            right: context.locale.localeName == 'ar'
                ? context.screenSize.width * 0.2
                : 0.0,
            left: context.locale.localeName == 'en'
                ? context.screenSize.width * 0.2
                : 0.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  context.locale.chooseLanguage,
                  style: context.textTheme.headline5?.copyWith(
                    fontSize: 23,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.read(currentLocaleProvider.notifier).state =
                      ref.read(selectedLocaleProvider);
                  Navigator.of(context).pop();
                },
                child: FutureBuilder<Configuration>(
                  future: ref.watch(configurationsProvider.future),
                  builder: (context, configs) {
                    if (!configs.hasData) return const SizedBox.shrink();
                    return Text(
                      context.locale.done,
                      style: context.textTheme.bodyText2!.copyWith(
                        color: Color(configs.data!.primaryColor.toInt),
                        fontWeight: FontWeight.w600,
                        fontSize: 15.0,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
