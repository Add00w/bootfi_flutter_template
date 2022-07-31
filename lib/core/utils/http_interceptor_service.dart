import 'package:flutter/foundation.dart' show debugPrint;
import 'package:hooks_riverpod/hooks_riverpod.dart' show Provider;
import 'package:http_interceptor/http_interceptor.dart'
    show
        InterceptedClient,
        InterceptorContract,
        RequestData,
        ResponseData,
        RetryPolicy;

class _InterceptorClientService implements InterceptorContract {
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

class _ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int get maxRetryAttempts => 2;

  @override
  bool shouldAttemptRetryOnException(Exception reason) {
    debugPrint(reason.toString());

    return false;
  }

  @override
  Future<bool> shouldAttemptRetryOnResponse(ResponseData response) async {
    if (response.statusCode == 401) {
      debugPrint("Retrying request...");
      //Todo
      // Perform your token refresh here.

      return true;
    }

    return false;
  }
}

final httpProvider = Provider<InterceptedClient>((ref) {
  final client = InterceptedClient.build(
    interceptors: [_InterceptorClientService()],
    retryPolicy: _ExpiredTokenRetryPolicy(),
  );

  ref.onDispose(client.close);
  return client;
});
