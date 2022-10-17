class SystemWindowPadding {
  int? left;
  int? right;
  int? top;
  int? bottom;

  SystemWindowPadding({this.left, this.right, this.top, this.bottom});

  /// Internal method to convert SystemWindowPadding to primitive dataTypes
  Map<String, int> getMap() {
    final Map<String, int> map = <String, int>{
      'left': left ?? 0,
      'right': right ?? 0,
      'top': top ?? 0,
      'bottom': bottom ?? 0,
    };
    return map;
  }

  /// Internal method to create symmetric padding across the axis
  static SystemWindowPadding setSymmetricPadding(int vertical, int horizontal) {
    return SystemWindowPadding(
        left: horizontal, right: horizontal, top: vertical, bottom: vertical);
  }
}
