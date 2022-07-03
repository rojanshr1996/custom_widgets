part of custom_widgets;

enum LoadingStatus { loading, stable }

/// Signature for EndOfPageListeners
typedef EndOfPageListenerCallback = void Function();

class CustomScrollLoading extends StatefulWidget {
  /// The [Widget] that this widget watches for changes on
  final Widget child;

  /// Called when the [child] reaches the end of the list
  final EndOfPageListenerCallback onEndOfPage;

  /// The offset to take into account when triggering [onEndOfPage] in pixels
  final int scrollOffset;

  /// Used to determine if loading of new data has finished. You should use set this if you aren't using a FutureBuilder or StreamBuilder
  final bool isLoading;

  /// Prevented update nested listview with other axis direction
  final Axis scrollDirection;

  final bool switchScroll;

  /// Loading indicator when [child] reaches the end of the list
  final Widget loadingIndicator;

  const CustomScrollLoading({
    Key? key,
    required this.child,
    required this.onEndOfPage,
    this.scrollOffset = 150,
    this.isLoading = false,
    this.switchScroll = false,
    this.scrollDirection = Axis.vertical,
    this.loadingIndicator = const CircularProgressIndicator(),
  }) : super(key: key);

  @override
  _CustomScrollLoadingState createState() => _CustomScrollLoadingState();
}

class _CustomScrollLoadingState extends State<CustomScrollLoading> {
  LoadingStatus loadMoreStatus = LoadingStatus.stable;

  @override
  void didUpdateWidget(CustomScrollLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isLoading) {
      loadMoreStatus = LoadingStatus.stable;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      child: Column(
        children: [
          Expanded(child: widget.child),
          loadMoreStatus == LoadingStatus.loading ? widget.loadingIndicator : const SizedBox(),
        ],
      ),
      onNotification: (notification) => _onNotification(notification, context),
    );
  }

  bool _onNotification(ScrollNotification notification, BuildContext context) {
    if (widget.scrollDirection == notification.metrics.axis) {
      if (notification is ScrollUpdateNotification) {
        if (widget.switchScroll) {
          if (notification.metrics.maxScrollExtent < notification.metrics.pixels &&
              notification.metrics.maxScrollExtent - notification.metrics.pixels >= widget.scrollOffset) {
            if (notification.metrics.axisDirection == AxisDirection.up) {
              _loadMore();
            }
          }
        } else {
          if (notification.metrics.maxScrollExtent > notification.metrics.pixels &&
              notification.metrics.maxScrollExtent - notification.metrics.pixels <= widget.scrollOffset) {
            if (notification.metrics.axisDirection == AxisDirection.down) {
              _loadMore();
            }
          }
        }

        return true;
      }

      if (notification is OverscrollNotification) {
        if (widget.switchScroll) {
          if (notification.overscroll < 0) {
            _loadMore();
          }
        } else {
          if (notification.overscroll > 0) {
            _loadMore();
          }
        }

        return true;
      }
    }
    return false;
  }

  void _loadMore() {
    if (loadMoreStatus == LoadingStatus.stable) {
      loadMoreStatus = LoadingStatus.loading;
      widget.onEndOfPage();
    }
  }
}
