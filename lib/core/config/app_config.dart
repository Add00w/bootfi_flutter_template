import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

@freezed
class Configuration with _$Configuration {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Configuration({
    required String apiUrl,
    required String sentryDNSKey,
    required String primaryColor,
  }) = _Configuration;

  factory Configuration.fromJson(Map<String, Object?> json) =>
      _$ConfigurationFromJson(json);
}

final configurationsProvider = FutureProvider<Configuration>((_) async {
  const currentServer = 'dev'; //Todo: Watch this from server provider
  final content = json.decode(
    await rootBundle.loadString('assets/config/$currentServer.json'),
  ) as Map<String, Object?>;
  return Configuration.fromJson(content);
});
