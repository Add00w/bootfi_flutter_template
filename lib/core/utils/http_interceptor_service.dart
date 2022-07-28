import 'package:flutter/foundation.dart' show debugPrint;
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;
import 'package:http_interceptor/http_interceptor.dart'
    show InterceptedClient, InterceptorContract, RequestData, ResponseData;

class InterceptorClientService implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    debugPrint("request:${data.url}");

    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint("response:${data.body} ");
    return data;
  }
}

final httpProvider = Provider<InterceptedClient>((ref) {
  final client = InterceptedClient.build(
    interceptors: [InterceptorClientService()],
  );

  ref.onDispose(client.close);
  return client;
});
