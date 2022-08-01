import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshableGridList extends StatefulWidget {
  const RefreshableGridList({
    Key? key,
    required this.refreshController,
    required this.child,
    required this.onLoading,
    required this.onRefresh,
    this.loadingText,
  }) : super(key: key);

  final RefreshController refreshController;

  final void Function()? onLoading;
  final void Function()? onRefresh;
  final Widget child;
  final String? loadingText;

  @override
  State<RefreshableGridList> createState() => _RefreshableGridListState();
}

class _RefreshableGridListState extends State<RefreshableGridList> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: widget.refreshController,
      enablePullUp: true,
      enablePullDown: true,
      footer: CustomFooter(
        builder: (BuildContext _, LoadStatus? mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = const Text('Pull to load');
          } else if (mode == LoadStatus.loading) {
            body = const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            );
          } else {
            body = widget.loadingText != null
                ? Text(widget.loadingText!)
                : const Text('No more data');
          }
          return SizedBox(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      onLoading: widget.onLoading,
      onRefresh: widget.onRefresh,
      child: widget.child,
    );
  }
}
