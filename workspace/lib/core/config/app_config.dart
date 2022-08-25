import 'dart:convert' show json;

import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers.dart';

part 'app_config.freezed.dart';
part 'app_config.g.dart';

@freezed
class Configuration with _$Configuration {
  // ignore: invalid_annotation_target
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory Configuration({
    required String envName,
    required String apiUrl,
    required String sentryDns,
    required String primaryColor,
  }) = _Configuration;

  factory Configuration.fromJson(Map<String, Object?> json) =>
      _$ConfigurationFromJson(json);
}

final configurationsProvider = FutureProvider<Configuration>((ref) async {
  // Watch for server changes
  final currentServer = ref.watch(serverProvider);
  final content = json.decode(
    await rootBundle.loadString('assets/config/$currentServer.json'),
  ) as Map<String, dynamic>;
  return Configuration.fromJson(content);
});
