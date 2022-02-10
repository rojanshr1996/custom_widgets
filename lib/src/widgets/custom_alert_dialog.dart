part of custom_widgets;

class CustomAlertDialog extends StatelessWidget {
  //Alert dialog content
  final Widget? title;

  /// The amount of space by which to inset the title child.
  final EdgeInsetsGeometry? titlePadding;

  /// Creates a widget that insets its child.
  final Widget? body;

  /// The amount of space by which to inset the content child.
  final EdgeInsetsGeometry contentPadding;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry actionsPadding;

  /// If [true] longer contents will be made scrollable
  final bool scrollable;

  /// {@template flutter.material.dialog.backgroundColor}
  /// The background color of the surface of this [CustomAlertDialog].
  ///
  /// This sets the [Material.color] on this [Dialog]'s [Material].
  ///
  /// If `null`, [ThemeData.dialogBackgroundColor] is used.
  /// {@endtemplate}
  final Color? backgroundColor;

  //Button components
  /// Used for the name of the left button
  final String leftButtonText;

  /// Used for the name of the right button
  final String? rightButtonText;

  /// Called when left side button is pressed
  final VoidCallback? leftButtonFunction;

  /// Called when right side button is pressed
  final VoidCallback? rightButtonFunction;

  /// Specifies the height of the button. Defaults to 48.0
  final double? buttonHeight;

  /// Used for adding color to the button
  final Color? buttonColor;

  /// Describes how to format the right side button name text
  final TextStyle? rightButtonTextStyle;

  /// Describes how to format the left side button name text
  final TextStyle? leftButtonTextStyle;

  /// [bool] value in order to toggle the decorations between the two bottons. Defaults to [false];
  final bool switchButtonDecoration;

  /// Species the radii for each corner of the button
  final BorderRadiusGeometry? borderRadius;

  /// Species the radii for each corner of the splash behaviour when pressing the button
  final BorderRadius? splashBorderRadius;

  /// {@template flutter.material.material.elevation}
  /// The z-coordinate at which to place this material relative to its parent.
  ///
  /// This controls the size of the shadow below the material and the opacity
  /// of the elevation overlay color if it is applied.
  ///
  /// If this is non-zero, the contents of the material are clipped, because the
  /// widget conceptually defines an independent printed piece of material.
  ///
  /// Defaults to 0. Changing this value will cause the shadow and the elevation
  /// overlay to animate over [Material.animationDuration].
  ///
  /// The value is non-negative.
  ///
  /// See also:
  ///
  ///  * [ThemeData.applyElevationOverlayColor] which controls the whether
  ///    an overlay color will be applied to indicate elevation.
  ///  * [Material.color] which may have an elevation overlay applied.
  ///
  /// {@endtemplate}
  final double buttonElevation;

  /// Species the direction of the button. [Axis.horizontal] aligns the buttons is a row.
  /// [Axis.vertical] aligns the buttons in a column.
  /// Defaults to [Axis.horizontal]
  final Axis? buttonDirection;

  /// [bool] value which toggles in order to show the loading state when the right button is pressed
  final bool? rightButtonloader;

  /// [bool] value which toggles in order to show the loading state when the left button is pressed
  final bool? leftButtonloader;

  /// The [Widget] that loads when the [loader] is set to true when the button is pressed
  final Widget? loadingIndicator;

  const CustomAlertDialog({
    Key? key,
    this.title,
    this.titlePadding,
    this.body,
    this.contentPadding = const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 16.0),
    this.actionsPadding = const EdgeInsets.fromLTRB(18.0, 16.0, 18.0, 16.0),
    this.scrollable = false,
    this.leftButtonText = "",
    this.leftButtonFunction,
    this.rightButtonText,
    this.rightButtonFunction,
    this.buttonColor = CustomColor.cpurple,
    this.rightButtonTextStyle = const TextStyle(color: CustomColor.cpurple),
    this.leftButtonTextStyle = const TextStyle(color: CustomColor.cwhite),
    this.buttonHeight = 48.0,
    this.switchButtonDecoration = false,
    this.backgroundColor,
    this.buttonElevation = 0.0,
    this.borderRadius,
    this.splashBorderRadius,
    this.buttonDirection = Axis.horizontal,
    this.rightButtonloader = false,
    this.leftButtonloader = false,
    this.loadingIndicator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double paddingScaleFactor = _paddingScaleFactor(MediaQuery.of(context).textScaleFactor);
    final TextDirection textDirection = Directionality.of(context);
    Widget? titleWidget;
    Widget? contentWidget;

    if (title != null) {
      final EdgeInsets defaultTitlePadding = EdgeInsets.fromLTRB(18.0, 18.0, 18.0, body == null ? 8.0 : 0.0);
      final EdgeInsets effectiveTitlePadding = titlePadding?.resolve(textDirection) ?? defaultTitlePadding;
      titleWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveTitlePadding.left * paddingScaleFactor,
          right: effectiveTitlePadding.right * paddingScaleFactor,
          top: effectiveTitlePadding.top * paddingScaleFactor,
          bottom: effectiveTitlePadding.bottom,
        ),
        child: Semantics(
          child: title,
          namesRoute: true,
          container: true,
        ),
      );
    }

    if (body != null) {
      final EdgeInsets effectiveContentPadding = contentPadding.resolve(textDirection);
      contentWidget = Padding(
        padding: EdgeInsets.only(
          left: effectiveContentPadding.left * paddingScaleFactor,
          right: effectiveContentPadding.right * paddingScaleFactor,
          top: title == null ? effectiveContentPadding.top * paddingScaleFactor : effectiveContentPadding.top,
          bottom: effectiveContentPadding.bottom,
        ),
        child: body,
      );
    }

    List<Widget> columnChildren;
    if (scrollable) {
      columnChildren = <Widget>[
        if (body != null)
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (title != null) titleWidget!,
                  if (body != null) contentWidget!,
                ],
              ),
            ),
          ),
        CustomTwoButtons(
          leftButtonFunction: leftButtonFunction,
          leftButtonText: leftButtonText,
          rightButtonText: rightButtonText,
          rightButtonFunction: rightButtonFunction,
          leftButtonTextStyle: leftButtonTextStyle,
          rightButtonTextStyle: rightButtonTextStyle,
          buttonColor: buttonColor,
          buttonHeight: buttonHeight,
          switchButtonDecoration: switchButtonDecoration,
          elevation: buttonElevation,
          borderRadius: borderRadius,
          splashBorderRadius: splashBorderRadius,
          leftButtonloader: leftButtonloader,
          rightButtonloader: rightButtonloader,
        ),
        const SizedBox(height: 4),
      ];
    } else {
      columnChildren = <Widget>[
        if (title != null) titleWidget!,
        if (body != null) Flexible(child: contentWidget!),
        Padding(
          padding: actionsPadding,
          child: CustomTwoButtons(
            leftButtonFunction: leftButtonFunction,
            leftButtonText: leftButtonText,
            rightButtonText: rightButtonText,
            rightButtonFunction: rightButtonFunction,
            leftButtonTextStyle: leftButtonTextStyle,
            rightButtonTextStyle: rightButtonTextStyle,
            buttonColor: buttonColor,
            buttonHeight: buttonHeight,
            switchButtonDecoration: switchButtonDecoration,
            elevation: buttonElevation,
            borderRadius: borderRadius,
            splashBorderRadius: splashBorderRadius,
            leftButtonloader: leftButtonloader,
            rightButtonloader: rightButtonloader,
          ),
        ),
        const SizedBox(height: 4),
      ];
    }

    Widget dialogChild = IntrinsicWidth(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: columnChildren,
      ),
    );

    return Dialog(
      backgroundColor: backgroundColor,
      elevation: 3,
      insetPadding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      clipBehavior: Clip.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: dialogChild,
    );
  }
}

double _paddingScaleFactor(double textScaleFactor) {
  final double clampedTextScaleFactor = textScaleFactor.clamp(1.0, 2.0).toDouble();
  // The final padding scale factor is clamped between 1/3 and 1. For example,
  // a non-scaled padding of 24 will produce a padding between 24 and 8.
  return lerpDouble(1.0, 1.0 / 3.0, clampedTextScaleFactor - 1.0)!;
}
